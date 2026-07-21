import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("DownloadClientConfig requests")
struct DownloadClientConfigRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleDownloadClientConfig: DownloadClientConfigResource {
		DownloadClientConfigResource(
			id: 1,
			downloadClientWorkingFolders: "_UNPACK_|_FAILED_",
			enableCompletedDownloadHandling: true,
			autoRedownloadFailed: true,
			autoRedownloadFailedFromInteractiveSearch: false
		)
	}

	@Test func downloadClientConfigRequestConstruction() {
		let request = SonarrRequest.downloadClientConfig

		#expect(request.method == .get)
		#expect(request.path == "api/v3/config/downloadclient")
	}

	@Test func downloadClientConfigByIdRequestConstruction() {
		let request = SonarrRequest.downloadClientConfig(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/config/downloadclient/1")
	}

	@Test func updateDownloadClientConfigRequestConstruction() throws {
		let request = SonarrRequest.updateDownloadClientConfig(id: 1, sampleDownloadClientConfig)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/config/downloadclient/1")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(DownloadClientConfigResource.self, from: try body.encode())
		#expect(decoded == sampleDownloadClientConfig)
	}

	@Test func downloadClientConfigResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"downloadClientWorkingFolders": "_UNPACK_|_FAILED_",
				"enableCompletedDownloadHandling": true,
				"autoRedownloadFailed": true,
				"autoRedownloadFailedFromInteractiveSearch": false
			}
			"""#.utf8
		)

		let config = try client.decoder.decode(DownloadClientConfigResource.self, from: json)

		#expect(config.id == 1)
		#expect(config.downloadClientWorkingFolders == "_UNPACK_|_FAILED_")
		#expect(config.enableCompletedDownloadHandling == true)
		#expect(config.autoRedownloadFailed == true)
		#expect(config.autoRedownloadFailedFromInteractiveSearch == false)
	}

	@Test func downloadClientConfigResourceDecodingWithNullWorkingFolders() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"downloadClientWorkingFolders": null,
				"enableCompletedDownloadHandling": false,
				"autoRedownloadFailed": false,
				"autoRedownloadFailedFromInteractiveSearch": false
			}
			"""#.utf8
		)

		let config = try client.decoder.decode(DownloadClientConfigResource.self, from: json)

		#expect(config.downloadClientWorkingFolders == nil)
	}
}
