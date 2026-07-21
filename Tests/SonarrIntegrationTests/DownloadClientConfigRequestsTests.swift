import Sonarr
import Testing

@Suite("DownloadClientConfig Requests", .serialized)
struct DownloadClientConfigRequestsTests {
	@Test
	func test_downloadClientConfig_downloadClientConfigById_updateDownloadClientConfig() async throws {
		let config = try await client.request(.downloadClientConfig)
		let id = try #require(config.id)

		let fetched = try await client.request(.downloadClientConfig(id: id))
		#expect(fetched.id == id)

		let toggled = DownloadClientConfigResource(
			id: id,
			downloadClientWorkingFolders: config.downloadClientWorkingFolders,
			enableCompletedDownloadHandling: config.enableCompletedDownloadHandling,
			autoRedownloadFailed: !config.autoRedownloadFailed,
			autoRedownloadFailedFromInteractiveSearch: config.autoRedownloadFailedFromInteractiveSearch
		)

		let updated = try await client.request(.updateDownloadClientConfig(id: id, toggled))
		#expect(updated.autoRedownloadFailed == !config.autoRedownloadFailed)

		// Restore the original value so this test doesn't leave the server's config mutated for other runs.
		_ = try await client.request(.updateDownloadClientConfig(id: id, config))
	}
}
