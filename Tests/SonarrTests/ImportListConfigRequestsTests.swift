import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("ImportListConfig requests")
struct ImportListConfigRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleImportListConfig: ImportListConfigResource {
		ImportListConfigResource(
			id: 1,
			listSyncLevel: .keepAndTag,
			listSyncTag: 3
		)
	}

	@Test func importListConfigRequestConstruction() {
		let request = SonarrRequest.importListConfig

		#expect(request.method == .get)
		#expect(request.path == "api/v3/config/importlist")
	}

	@Test func importListConfigByIdRequestConstruction() {
		let request = SonarrRequest.importListConfig(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/config/importlist/1")
	}

	@Test func updateImportListConfigRequestConstruction() throws {
		let request = SonarrRequest.updateImportListConfig(id: 1, sampleImportListConfig)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/config/importlist/1")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["listSyncLevel"] as? String == "keepAndTag")
		#expect(json["listSyncTag"] as? Int == 3)
	}

	@Test func importListConfigResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"listSyncLevel": "keepAndTag",
				"listSyncTag": 3
			}
			"""#.utf8
		)

		let config = try client.decoder.decode(ImportListConfigResource.self, from: json)

		#expect(config.id == 1)
		#expect(config.listSyncLevel == .keepAndTag)
		#expect(config.listSyncTag == 3)
	}

	@Test func importListConfigResourceDecodingWithNullFields() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"listSyncLevel": null,
				"listSyncTag": null
			}
			"""#.utf8
		)

		let config = try client.decoder.decode(ImportListConfigResource.self, from: json)

		#expect(config.listSyncLevel == nil)
		#expect(config.listSyncTag == nil)
	}
}
