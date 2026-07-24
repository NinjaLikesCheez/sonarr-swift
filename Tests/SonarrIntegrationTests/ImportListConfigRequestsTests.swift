import Sonarr
import Testing

@Suite("ImportListConfig Requests", .serialized)
struct ImportListConfigRequestsTests {
	@Test
	func test_importListConfig_importListConfigById_updateImportListConfig() async throws {
		let config = try await client.request(.importListConfig)
		let id = try #require(config.id)

		let fetched = try await client.request(.importListConfig(id: id))
		#expect(fetched.id == id)

		let toggled = ImportListConfigResource(
			id: id,
			listSyncLevel: config.listSyncLevel == .disabled ? .logOnly : .disabled,
			listSyncTag: config.listSyncTag
		)

		let updated = try await client.request(.updateImportListConfig(id: id, toggled))
		#expect(updated.listSyncLevel == toggled.listSyncLevel)

		// Restore the original value so this test doesn't leave the server's config mutated for other runs.
		_ = try await client.request(.updateImportListConfig(id: id, config))
	}
}
