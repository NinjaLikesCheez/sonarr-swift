import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("IndexerConfig requests")
struct IndexerConfigRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleIndexerConfig: IndexerConfigResource {
		IndexerConfigResource(
			id: 1,
			minimumAge: 0,
			retention: 0,
			maximumSize: 0,
			rssSyncInterval: 15
		)
	}

	@Test func indexerConfigRequestConstruction() {
		let request = SonarrRequest.indexerConfig

		#expect(request.method == .get)
		#expect(request.path == "api/v3/config/indexer")
	}

	@Test func indexerConfigByIdRequestConstruction() {
		let request = SonarrRequest.indexerConfig(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/config/indexer/1")
	}

	@Test func updateIndexerConfigRequestConstruction() throws {
		let request = SonarrRequest.updateIndexerConfig(id: 1, sampleIndexerConfig)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/config/indexer/1")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["minimumAge"] as? Int == 0)
		#expect(json["retention"] as? Int == 0)
		#expect(json["maximumSize"] as? Int == 0)
		#expect(json["rssSyncInterval"] as? Int == 15)
	}

	@Test func indexerConfigResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"minimumAge": 0,
				"retention": 0,
				"maximumSize": 0,
				"rssSyncInterval": 15
			}
			"""#.utf8
		)

		let config = try client.decoder.decode(IndexerConfigResource.self, from: json)

		#expect(config.id == 1)
		#expect(config.minimumAge == 0)
		#expect(config.retention == 0)
		#expect(config.maximumSize == 0)
		#expect(config.rssSyncInterval == 15)
	}

	@Test func indexerConfigResourceDecodingWithNullFields() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"minimumAge": null,
				"retention": null,
				"maximumSize": null,
				"rssSyncInterval": null
			}
			"""#.utf8
		)

		let config = try client.decoder.decode(IndexerConfigResource.self, from: json)

		#expect(config.minimumAge == nil)
		#expect(config.retention == nil)
		#expect(config.maximumSize == nil)
		#expect(config.rssSyncInterval == nil)
	}
}
