import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("Tag requests")
struct TagRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleTag: TagResource {
		TagResource(id: 1, label: "anime")
	}

	@Test func tagsRequestConstruction() {
		let request = SonarrRequest.tags

		#expect(request.method == .get)
		#expect(request.path == "api/v3/tag")
	}

	@Test func tagRequestConstruction() {
		let request = SonarrRequest.tag(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/tag/1")
	}

	@Test func addTagRequestConstruction() throws {
		let request = SonarrRequest.addTag(sampleTag)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/tag")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["label"] as? String == "anime")
	}

	@Test func updateTagRequestConstruction() throws {
		let request = SonarrRequest.updateTag(id: 1, sampleTag)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/tag/1")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["label"] as? String == "anime")
	}

	@Test func deleteTagRequestConstruction() {
		let request = SonarrRequest.deleteTag(id: 1)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/tag/1")
	}

	@Test func tagResourceDecoding() throws {
		let json = Data(#"{"id": 1, "label": "anime"}"#.utf8)

		let tag = try client.decoder.decode(TagResource.self, from: json)

		#expect(tag.id == 1)
		#expect(tag.label == "anime")
	}

	@Test func tagResourceDecodingWithNullableFieldsMissing() throws {
		let json = Data(#"{"id": 2}"#.utf8)

		let tag = try client.decoder.decode(TagResource.self, from: json)

		#expect(tag.id == 2)
		#expect(tag.label == nil)
	}

	@Test func tagResourceListDecoding() throws {
		let json = Data(#"[{"id": 1, "label": "anime"}]"#.utf8)

		let tags = try client.decoder.decode([TagResource].self, from: json)

		#expect(tags.count == 1)
		#expect(tags.first?.label == "anime")
	}

	@Test func tagDetailsRequestConstruction() {
		let request = SonarrRequest.tagDetails

		#expect(request.method == .get)
		#expect(request.path == "api/v3/tag/detail")
	}

	@Test func tagDetailsByIdRequestConstruction() {
		let request = SonarrRequest.tagDetails(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/tag/detail/1")
	}

	@Test func tagDetailsResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"label": "anime",
				"delayProfileIds": [1],
				"importListIds": [],
				"notificationIds": [2],
				"restrictionIds": [],
				"indexerIds": [3],
				"downloadClientIds": [],
				"autoTagIds": [4],
				"seriesIds": [5, 6]
			}
			"""#.utf8
		)

		let details = try client.decoder.decode(TagDetailsResource.self, from: json)

		#expect(details.id == 1)
		#expect(details.label == "anime")
		#expect(details.delayProfileIds == [1])
		#expect(details.importListIds == [])
		#expect(details.notificationIds == [2])
		#expect(details.restrictionIds == [])
		#expect(details.indexerIds == [3])
		#expect(details.downloadClientIds == [])
		#expect(details.autoTagIds == [4])
		#expect(details.seriesIds == [5, 6])
	}

	@Test func tagDetailsResourceDecodingWithNullableFieldsMissing() throws {
		let json = Data(#"{"id": 2}"#.utf8)

		let details = try client.decoder.decode(TagDetailsResource.self, from: json)

		#expect(details.id == 2)
		#expect(details.label == nil)
		#expect(details.delayProfileIds == nil)
		#expect(details.seriesIds == nil)
	}

	@Test func tagDetailsResourceListDecoding() throws {
		let json = Data(#"[{"id": 1, "label": "anime"}]"#.utf8)

		let details = try client.decoder.decode([TagDetailsResource].self, from: json)

		#expect(details.count == 1)
		#expect(details.first?.label == "anime")
	}
}
