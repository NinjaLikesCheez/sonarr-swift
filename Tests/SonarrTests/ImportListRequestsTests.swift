import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("ImportList requests")
struct ImportListRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleImportList: ImportListResource {
		ImportListResource(
			id: 1,
			name: "Trakt Watchlist",
			implementationName: "Trakt Watchlist",
			implementation: "TraktWatchlistImport",
			configContract: "TraktWatchlistSettings",
			infoLink: "https://wiki.servarr.com/sonarr/settings#import-lists",
			tags: [],
			enableAutomaticAdd: true,
			searchForMissingEpisodes: false,
			shouldMonitor: .all,
			monitorNewItems: .all,
			qualityProfileId: 1,
			seriesType: .standard,
			seasonFolder: true,
			listType: .trakt,
			listOrder: 0
		)
	}

	@Test func importListsRequestConstruction() {
		let request = SonarrRequest.importLists

		#expect(request.method == .get)
		#expect(request.path == "api/v3/importlist")
	}

	@Test func importListRequestConstruction() {
		let request = SonarrRequest.importList(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/importlist/1")
	}

	@Test func addImportListRequestConstruction() throws {
		let request = SonarrRequest.addImportList(sampleImportList, forceSave: true)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/importlist")

		let prepared = request.prepare(URLRequest(url: URL(string: "http://localhost:8989/api/v3/importlist")!))
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == [URLQueryItem(name: "forceSave", value: "true")])

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(ImportListResource.self, from: try body.encode())
		#expect(decoded == sampleImportList)
	}

	@Test func addImportListRequestConstructionDefaultsForceSaveFalse() {
		let request = SonarrRequest.addImportList(sampleImportList)

		let prepared = request.prepare(URLRequest(url: URL(string: "http://localhost:8989/api/v3/importlist")!))
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == [URLQueryItem(name: "forceSave", value: "false")])
	}

	@Test func updateImportListRequestConstruction() throws {
		let request = SonarrRequest.updateImportList(id: 1, sampleImportList, forceSave: true)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/importlist/1")

		let prepared = request.prepare(
			URLRequest(url: URL(string: "http://localhost:8989/api/v3/importlist/1")!)
		)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == [URLQueryItem(name: "forceSave", value: "true")])

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(ImportListResource.self, from: try body.encode())
		#expect(decoded == sampleImportList)
	}

	@Test func deleteImportListRequestConstruction() {
		let request = SonarrRequest.deleteImportList(id: 1)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/importlist/1")
	}

	@Test func updateImportListsRequestConstruction() throws {
		let bulkResource = ImportListBulkResource(ids: [1, 2, 3], tags: [4], applyTags: .add, enableAutomaticAdd: true)
		let request = SonarrRequest.updateImportLists(bulkResource)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/importlist/bulk")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(ImportListBulkResourceFixture.self, from: try body.encode())
		#expect(decoded.ids == [1, 2, 3])
		#expect(decoded.tags == [4])
		#expect(decoded.applyTags == "add")
		#expect(decoded.enableAutomaticAdd == true)
	}

	@Test func deleteImportListsRequestConstruction() throws {
		let bulkResource = ImportListBulkResource(ids: [1, 2, 3])
		let request = SonarrRequest.deleteImportLists(bulkResource)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/importlist/bulk")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(ImportListBulkResourceFixture.self, from: try body.encode())
		#expect(decoded.ids == [1, 2, 3])
	}

	@Test func importListSchemaRequestConstruction() {
		let request = SonarrRequest.importListSchema

		#expect(request.method == .get)
		#expect(request.path == "api/v3/importlist/schema")
	}

	@Test func testImportListRequestConstruction() throws {
		let request = SonarrRequest.testImportList(sampleImportList, forceTest: true)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/importlist/test")

		let prepared = request.prepare(
			URLRequest(url: URL(string: "http://localhost:8989/api/v3/importlist/test")!)
		)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == [URLQueryItem(name: "forceTest", value: "true")])

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(ImportListResource.self, from: try body.encode())
		#expect(decoded == sampleImportList)
	}

	@Test func testAllImportListsRequestConstruction() {
		let request = SonarrRequest.testAllImportLists

		#expect(request.method == .post)
		#expect(request.path == "api/v3/importlist/testall")
	}

	@Test func performImportListActionRequestConstruction() throws {
		let request = SonarrRequest.performImportListAction(name: "getMissingMovies", sampleImportList)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/importlist/action/getMissingMovies")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(ImportListResource.self, from: try body.encode())
		#expect(decoded == sampleImportList)
	}

	@Test func importListResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"name": "Trakt Watchlist",
				"fields": [],
				"implementationName": "Trakt Watchlist",
				"implementation": "TraktWatchlistImport",
				"configContract": "TraktWatchlistSettings",
				"infoLink": "https://wiki.servarr.com/sonarr/settings#import-lists",
				"message": {
					"message": "Some info",
					"type": "info"
				},
				"tags": [1, 2],
				"enableAutomaticAdd": true,
				"searchForMissingEpisodes": false,
				"shouldMonitor": "all",
				"monitorNewItems": "all",
				"rootFolderPath": "/tv/",
				"qualityProfileId": 1,
				"seriesType": "standard",
				"seasonFolder": true,
				"listType": "trakt",
				"listOrder": 0,
				"minRefreshInterval": "01:00:00"
			}
			"""#.utf8
		)

		let importList = try client.decoder.decode(ImportListResource.self, from: json)

		#expect(importList.id == 1)
		#expect(importList.name == "Trakt Watchlist")
		#expect(importList.implementation == "TraktWatchlistImport")
		#expect(importList.message?.message == "Some info")
		#expect(importList.message?.type == .info)
		#expect(importList.tags == [1, 2])
		#expect(importList.enableAutomaticAdd == true)
		#expect(importList.searchForMissingEpisodes == false)
		#expect(importList.shouldMonitor == .all)
		#expect(importList.monitorNewItems == .all)
		#expect(importList.rootFolderPath == "/tv/")
		#expect(importList.qualityProfileId == 1)
		#expect(importList.seriesType == .standard)
		#expect(importList.seasonFolder == true)
		#expect(importList.listType == .trakt)
		#expect(importList.listOrder == 0)
		#expect(importList.minRefreshInterval == "01:00:00")
	}

	@Test func importListResourceListDecodingWithPresets() throws {
		let json = Data(
			#"""
			[
				{
					"name": "Plex Watchlist",
					"implementationName": "Plex Watchlist",
					"implementation": "PlexImport",
					"configContract": "PlexListSettings",
					"infoLink": null,
					"fields": [],
					"enableAutomaticAdd": false,
					"searchForMissingEpisodes": false,
					"shouldMonitor": "none",
					"monitorNewItems": "none",
					"qualityProfileId": 1,
					"seriesType": "standard",
					"seasonFolder": true,
					"listType": "plex",
					"listOrder": 0,
					"presets": [
						{
							"name": "Plex Watchlist",
							"implementationName": "Plex Watchlist",
							"implementation": "PlexImport",
							"configContract": "PlexListSettings",
							"infoLink": null,
							"fields": [],
							"enableAutomaticAdd": false,
							"searchForMissingEpisodes": false,
							"shouldMonitor": "none",
							"monitorNewItems": "none",
							"qualityProfileId": 1,
							"seriesType": "standard",
							"seasonFolder": true,
							"listType": "plex",
							"listOrder": 0
						}
					]
				}
			]
			"""#.utf8
		)

		let importLists = try client.decoder.decode([ImportListResource].self, from: json)

		#expect(importLists.count == 1)
		#expect(importLists.first?.presets?.count == 1)
		#expect(importLists.first?.presets?.first?.implementation == "PlexImport")
	}
}

private struct ImportListBulkResourceFixture: Decodable {
	let ids: [Int]?
	let tags: [Int]?
	let applyTags: String?
	let enableAutomaticAdd: Bool?
}
