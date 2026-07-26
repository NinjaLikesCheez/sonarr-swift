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
		let decoded = try client.decoder.decode(TagResource.self, from: try body.encode())
		#expect(decoded == sampleTag)
	}

	@Test func updateTagRequestConstruction() throws {
		let request = SonarrRequest.updateTag(id: 1, sampleTag)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/tag/1")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(TagResource.self, from: try body.encode())
		#expect(decoded == sampleTag)
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
}
