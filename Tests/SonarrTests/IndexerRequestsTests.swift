import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("Indexer requests")
struct IndexerRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleIndexer: IndexerResource {
		IndexerResource(
			id: 1,
			name: "NZBgeek",
			implementationName: "Newznab",
			implementation: "Newznab",
			configContract: "NewznabSettings",
			infoLink: "https://wiki.servarr.com/sonarr/settings#indexers",
			tags: [],
			enableRss: true,
			enableAutomaticSearch: true,
			enableInteractiveSearch: true,
			supportsRss: true,
			supportsSearch: true,
			protocol: .usenet,
			priority: 25,
			seasonSearchMaximumSingleEpisodeAge: 0,
			downloadClientId: 0
		)
	}

	@Test func indexersRequestConstruction() {
		let request = SonarrRequest.indexers

		#expect(request.method == .get)
		#expect(request.path == "api/v3/indexer")
	}

	@Test func indexerRequestConstruction() {
		let request = SonarrRequest.indexer(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/indexer/1")
	}

	@Test func addIndexerRequestConstruction() throws {
		let request = SonarrRequest.addIndexer(sampleIndexer, forceSave: true)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/indexer")

		let prepared = request.prepare(URLRequest(url: URL(string: "http://localhost:8989/api/v3/indexer")!))
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == [URLQueryItem(name: "forceSave", value: "true")])

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["name"] as? String == "NZBgeek")
		#expect(json["implementationName"] as? String == "Newznab")
		#expect(json["implementation"] as? String == "Newznab")
		#expect(json["configContract"] as? String == "NewznabSettings")
		#expect(json["infoLink"] as? String == "https://wiki.servarr.com/sonarr/settings#indexers")
		#expect(json["tags"] as? [Int] == [])
		#expect(json["enableRss"] as? Bool == true)
		#expect(json["enableAutomaticSearch"] as? Bool == true)
		#expect(json["enableInteractiveSearch"] as? Bool == true)
		#expect(json["supportsRss"] as? Bool == true)
		#expect(json["supportsSearch"] as? Bool == true)
		#expect(json["protocol"] as? String == "usenet")
		#expect(json["priority"] as? Int == 25)
		#expect(json["seasonSearchMaximumSingleEpisodeAge"] as? Int == 0)
		#expect(json["downloadClientId"] as? Int == 0)
	}

	@Test func addIndexerRequestConstructionDefaultsForceSaveFalse() {
		let request = SonarrRequest.addIndexer(sampleIndexer)

		let prepared = request.prepare(URLRequest(url: URL(string: "http://localhost:8989/api/v3/indexer")!))
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == [URLQueryItem(name: "forceSave", value: "false")])
	}

	@Test func updateIndexerRequestConstruction() throws {
		let request = SonarrRequest.updateIndexer(id: 1, sampleIndexer, forceSave: true)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/indexer/1")

		let prepared = request.prepare(
			URLRequest(url: URL(string: "http://localhost:8989/api/v3/indexer/1")!)
		)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == [URLQueryItem(name: "forceSave", value: "true")])

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["name"] as? String == "NZBgeek")
		#expect(json["implementationName"] as? String == "Newznab")
		#expect(json["implementation"] as? String == "Newznab")
		#expect(json["configContract"] as? String == "NewznabSettings")
		#expect(json["infoLink"] as? String == "https://wiki.servarr.com/sonarr/settings#indexers")
		#expect(json["tags"] as? [Int] == [])
		#expect(json["enableRss"] as? Bool == true)
		#expect(json["enableAutomaticSearch"] as? Bool == true)
		#expect(json["enableInteractiveSearch"] as? Bool == true)
		#expect(json["supportsRss"] as? Bool == true)
		#expect(json["supportsSearch"] as? Bool == true)
		#expect(json["protocol"] as? String == "usenet")
		#expect(json["priority"] as? Int == 25)
		#expect(json["seasonSearchMaximumSingleEpisodeAge"] as? Int == 0)
		#expect(json["downloadClientId"] as? Int == 0)
	}

	@Test func deleteIndexerRequestConstruction() {
		let request = SonarrRequest.deleteIndexer(id: 1)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/indexer/1")
	}

	@Test func updateIndexersRequestConstruction() throws {
		let bulkResource = IndexerBulkResource(ids: [1, 2, 3], tags: [4], applyTags: .add, enableRss: true, priority: 25)
		let request = SonarrRequest.updateIndexers(bulkResource)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/indexer/bulk")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["ids"] as? [Int] == [1, 2, 3])
		#expect(json["tags"] as? [Int] == [4])
		#expect(json["applyTags"] as? String == "add")
		#expect(json["enableRss"] as? Bool == true)
		#expect(json["priority"] as? Int == 25)
	}

	@Test func deleteIndexersRequestConstruction() throws {
		let bulkResource = IndexerBulkResource(ids: [1, 2, 3])
		let request = SonarrRequest.deleteIndexers(bulkResource)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/indexer/bulk")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["ids"] as? [Int] == [1, 2, 3])
	}

	@Test func indexerSchemaRequestConstruction() {
		let request = SonarrRequest.indexerSchema

		#expect(request.method == .get)
		#expect(request.path == "api/v3/indexer/schema")
	}

	@Test func testIndexerRequestConstruction() throws {
		let request = SonarrRequest.testIndexer(sampleIndexer, forceTest: true)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/indexer/test")

		let prepared = request.prepare(
			URLRequest(url: URL(string: "http://localhost:8989/api/v3/indexer/test")!)
		)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == [URLQueryItem(name: "forceTest", value: "true")])

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["name"] as? String == "NZBgeek")
		#expect(json["implementationName"] as? String == "Newznab")
		#expect(json["implementation"] as? String == "Newznab")
		#expect(json["configContract"] as? String == "NewznabSettings")
		#expect(json["infoLink"] as? String == "https://wiki.servarr.com/sonarr/settings#indexers")
		#expect(json["tags"] as? [Int] == [])
		#expect(json["enableRss"] as? Bool == true)
		#expect(json["enableAutomaticSearch"] as? Bool == true)
		#expect(json["enableInteractiveSearch"] as? Bool == true)
		#expect(json["supportsRss"] as? Bool == true)
		#expect(json["supportsSearch"] as? Bool == true)
		#expect(json["protocol"] as? String == "usenet")
		#expect(json["priority"] as? Int == 25)
		#expect(json["seasonSearchMaximumSingleEpisodeAge"] as? Int == 0)
		#expect(json["downloadClientId"] as? Int == 0)
	}

	@Test func testAllIndexersRequestConstruction() {
		let request = SonarrRequest.testAllIndexers

		#expect(request.method == .post)
		#expect(request.path == "api/v3/indexer/testall")
	}

	@Test func performIndexerActionRequestConstruction() throws {
		let request = SonarrRequest.performIndexerAction(name: "newznabCategories", sampleIndexer)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/indexer/action/newznabCategories")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["name"] as? String == "NZBgeek")
		#expect(json["implementationName"] as? String == "Newznab")
		#expect(json["implementation"] as? String == "Newznab")
		#expect(json["configContract"] as? String == "NewznabSettings")
		#expect(json["infoLink"] as? String == "https://wiki.servarr.com/sonarr/settings#indexers")
		#expect(json["tags"] as? [Int] == [])
		#expect(json["enableRss"] as? Bool == true)
		#expect(json["enableAutomaticSearch"] as? Bool == true)
		#expect(json["enableInteractiveSearch"] as? Bool == true)
		#expect(json["supportsRss"] as? Bool == true)
		#expect(json["supportsSearch"] as? Bool == true)
		#expect(json["protocol"] as? String == "usenet")
		#expect(json["priority"] as? Int == 25)
		#expect(json["seasonSearchMaximumSingleEpisodeAge"] as? Int == 0)
		#expect(json["downloadClientId"] as? Int == 0)
	}

	@Test func indexerResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"name": "NZBgeek",
				"fields": [],
				"implementationName": "Newznab",
				"implementation": "Newznab",
				"configContract": "NewznabSettings",
				"infoLink": "https://wiki.servarr.com/sonarr/settings#indexers",
				"message": {
					"message": "Some info",
					"type": "info"
				},
				"tags": [1, 2],
				"enableRss": true,
				"enableAutomaticSearch": true,
				"enableInteractiveSearch": false,
				"supportsRss": true,
				"supportsSearch": true,
				"protocol": "usenet",
				"priority": 25,
				"seasonSearchMaximumSingleEpisodeAge": 0,
				"downloadClientId": 0
			}
			"""#.utf8
		)

		let indexer = try client.decoder.decode(IndexerResource.self, from: json)

		#expect(indexer.id == 1)
		#expect(indexer.name == "NZBgeek")
		#expect(indexer.implementation == "Newznab")
		#expect(indexer.message?.message == "Some info")
		#expect(indexer.message?.type == .info)
		#expect(indexer.tags == [1, 2])
		#expect(indexer.enableRss == true)
		#expect(indexer.enableAutomaticSearch == true)
		#expect(indexer.enableInteractiveSearch == false)
		#expect(indexer.supportsRss == true)
		#expect(indexer.supportsSearch == true)
		#expect(indexer.protocol == .usenet)
		#expect(indexer.priority == 25)
		#expect(indexer.seasonSearchMaximumSingleEpisodeAge == 0)
		#expect(indexer.downloadClientId == 0)
	}

	@Test func indexerResourceListDecodingWithPresets() throws {
		let json = Data(
			#"""
			[
				{
					"name": "Newznab",
					"implementationName": "Newznab",
					"implementation": "Newznab",
					"configContract": "NewznabSettings",
					"infoLink": null,
					"fields": [],
					"enableRss": false,
					"enableAutomaticSearch": false,
					"enableInteractiveSearch": false,
					"supportsRss": true,
					"supportsSearch": true,
					"protocol": "usenet",
					"priority": 25,
					"seasonSearchMaximumSingleEpisodeAge": 0,
					"downloadClientId": 0,
					"presets": [
						{
							"name": "NZBgeek",
							"implementationName": "Newznab",
							"implementation": "Newznab",
							"configContract": "NewznabSettings",
							"infoLink": null,
							"fields": [],
							"enableRss": false,
							"enableAutomaticSearch": false,
							"enableInteractiveSearch": false,
							"supportsRss": true,
							"supportsSearch": true,
							"protocol": "usenet",
							"priority": 25,
							"seasonSearchMaximumSingleEpisodeAge": 0,
							"downloadClientId": 0
						}
					]
				}
			]
			"""#.utf8
		)

		let indexers = try client.decoder.decode([IndexerResource].self, from: json)

		#expect(indexers.count == 1)
		#expect(indexers.first?.presets?.count == 1)
		#expect(indexers.first?.presets?.first?.implementation == "Newznab")
	}
}
