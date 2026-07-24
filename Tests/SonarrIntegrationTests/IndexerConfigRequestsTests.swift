import Sonarr
import Testing

@Suite("IndexerConfig Requests", .serialized)
struct IndexerConfigRequestsTests {
	@Test
	func test_indexerConfig_indexerConfigById_updateIndexerConfig() async throws {
		let config = try await client.request(.indexerConfig)
		let id = try #require(config.id)

		let fetched = try await client.request(.indexerConfig(id: id))
		#expect(fetched.id == id)

		let toggled = IndexerConfigResource(
			id: id,
			minimumAge: config.minimumAge,
			retention: config.retention,
			maximumSize: config.maximumSize,
			rssSyncInterval: (config.rssSyncInterval ?? 15) == 15 ? 30 : 15
		)

		let updated = try await client.request(.updateIndexerConfig(id: id, toggled))
		#expect(updated.rssSyncInterval == toggled.rssSyncInterval)

		// Restore the original value so this test doesn't leave the server's config mutated for other runs.
		_ = try await client.request(.updateIndexerConfig(id: id, config))
	}
}
