import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("DownloadClient requests")
struct DownloadClientRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleDownloadClient: DownloadClientResource {
		DownloadClientResource(
			id: 1,
			name: "SABnzbd",
			implementationName: "SABnzbd",
			implementation: "Sabnzbd",
			configContract: "SabnzbdSettings",
			infoLink: "https://wiki.servarr.com/sonarr/settings#download-clients",
			tags: [],
			enable: true,
			protocol: .usenet,
			priority: 1,
			removeCompletedDownloads: false,
			removeFailedDownloads: false
		)
	}

	@Test func downloadClientsRequestConstruction() {
		let request = SonarrRequest.downloadClients

		#expect(request.method == .get)
		#expect(request.path == "api/v3/downloadclient")
	}

	@Test func downloadClientRequestConstruction() {
		let request = SonarrRequest.downloadClient(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/downloadclient/1")
	}

	@Test func addDownloadClientRequestConstruction() throws {
		let request = SonarrRequest.addDownloadClient(sampleDownloadClient, forceSave: true)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/downloadclient")

		let prepared = request.prepare(URLRequest(url: URL(string: "http://localhost:8989/api/v3/downloadclient")!))
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == [URLQueryItem(name: "forceSave", value: "true")])

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(DownloadClientResource.self, from: try body.encode())
		#expect(decoded == sampleDownloadClient)
	}

	@Test func addDownloadClientRequestConstructionDefaultsForceSaveFalse() {
		let request = SonarrRequest.addDownloadClient(sampleDownloadClient)

		let prepared = request.prepare(URLRequest(url: URL(string: "http://localhost:8989/api/v3/downloadclient")!))
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == [URLQueryItem(name: "forceSave", value: "false")])
	}

	@Test func updateDownloadClientRequestConstruction() throws {
		let request = SonarrRequest.updateDownloadClient(id: 1, sampleDownloadClient, forceSave: true)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/downloadclient/1")

		let prepared = request.prepare(
			URLRequest(url: URL(string: "http://localhost:8989/api/v3/downloadclient/1")!)
		)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == [URLQueryItem(name: "forceSave", value: "true")])

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(DownloadClientResource.self, from: try body.encode())
		#expect(decoded == sampleDownloadClient)
	}

	@Test func deleteDownloadClientRequestConstruction() {
		let request = SonarrRequest.deleteDownloadClient(id: 1)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/downloadclient/1")
	}

	@Test func updateDownloadClientsRequestConstruction() throws {
		let bulkResource = DownloadClientBulkResource(ids: [1, 2, 3], tags: [4], applyTags: .add, enable: true)
		let request = SonarrRequest.updateDownloadClients(bulkResource)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/downloadclient/bulk")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(DownloadClientBulkResourceFixture.self, from: try body.encode())
		#expect(decoded.ids == [1, 2, 3])
		#expect(decoded.tags == [4])
		#expect(decoded.applyTags == "add")
		#expect(decoded.enable == true)
	}

	@Test func deleteDownloadClientsRequestConstruction() throws {
		let bulkResource = DownloadClientBulkResource(ids: [1, 2, 3])
		let request = SonarrRequest.deleteDownloadClients(bulkResource)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/downloadclient/bulk")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(DownloadClientBulkResourceFixture.self, from: try body.encode())
		#expect(decoded.ids == [1, 2, 3])
	}

	@Test func downloadClientSchemaRequestConstruction() {
		let request = SonarrRequest.downloadClientSchema

		#expect(request.method == .get)
		#expect(request.path == "api/v3/downloadclient/schema")
	}

	@Test func testDownloadClientRequestConstruction() throws {
		let request = SonarrRequest.testDownloadClient(sampleDownloadClient, forceTest: true)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/downloadclient/test")

		let prepared = request.prepare(
			URLRequest(url: URL(string: "http://localhost:8989/api/v3/downloadclient/test")!)
		)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == [URLQueryItem(name: "forceTest", value: "true")])

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(DownloadClientResource.self, from: try body.encode())
		#expect(decoded == sampleDownloadClient)
	}

	@Test func testAllDownloadClientsRequestConstruction() {
		let request = SonarrRequest.testAllDownloadClients

		#expect(request.method == .post)
		#expect(request.path == "api/v3/downloadclient/testall")
	}

	@Test func performDownloadClientActionRequestConstruction() throws {
		let request = SonarrRequest.performDownloadClientAction(name: "checkForUpdates", sampleDownloadClient)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/downloadclient/action/checkForUpdates")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(DownloadClientResource.self, from: try body.encode())
		#expect(decoded == sampleDownloadClient)
	}

	@Test func downloadClientResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"name": "SABnzbd",
				"fields": [],
				"implementationName": "SABnzbd",
				"implementation": "Sabnzbd",
				"configContract": "SabnzbdSettings",
				"infoLink": "https://wiki.servarr.com/sonarr/settings#download-clients",
				"message": {
					"message": "Some info",
					"type": "info"
				},
				"tags": [1, 2],
				"enable": true,
				"protocol": "usenet",
				"priority": 1,
				"removeCompletedDownloads": false,
				"removeFailedDownloads": true
			}
			"""#.utf8
		)

		let downloadClient = try client.decoder.decode(DownloadClientResource.self, from: json)

		#expect(downloadClient.id == 1)
		#expect(downloadClient.name == "SABnzbd")
		#expect(downloadClient.implementation == "Sabnzbd")
		#expect(downloadClient.message?.message == "Some info")
		#expect(downloadClient.message?.type == .info)
		#expect(downloadClient.tags == [1, 2])
		#expect(downloadClient.protocol == .usenet)
		#expect(downloadClient.priority == 1)
		#expect(downloadClient.removeCompletedDownloads == false)
		#expect(downloadClient.removeFailedDownloads == true)
	}

	@Test func downloadClientResourceListDecodingWithPresets() throws {
		let json = Data(
			#"""
			[
				{
					"name": "qBittorrent",
					"implementationName": "qBittorrent",
					"implementation": "QBittorrent",
					"configContract": "QBittorrentSettings",
					"infoLink": null,
					"fields": [],
					"enable": false,
					"protocol": "torrent",
					"priority": 1,
					"removeCompletedDownloads": false,
					"removeFailedDownloads": false,
					"presets": [
						{
							"name": "qBittorrent",
							"implementationName": "qBittorrent",
							"implementation": "QBittorrent",
							"configContract": "QBittorrentSettings",
							"infoLink": null,
							"fields": [],
							"enable": false,
							"protocol": "torrent",
							"priority": 1,
							"removeCompletedDownloads": false,
							"removeFailedDownloads": false
						}
					]
				}
			]
			"""#.utf8
		)

		let downloadClients = try client.decoder.decode([DownloadClientResource].self, from: json)

		#expect(downloadClients.count == 1)
		#expect(downloadClients.first?.presets?.count == 1)
		#expect(downloadClients.first?.presets?.first?.implementation == "QBittorrent")
	}
}

private struct DownloadClientBulkResourceFixture: Decodable {
	let ids: [Int]?
	let tags: [Int]?
	let applyTags: String?
	let enable: Bool?
}
