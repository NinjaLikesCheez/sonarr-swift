import Sonarr
import Testing

@Suite("Tag Requests", .serialized)
struct TagRequestsTests {
	@Test
	func test_addTag_tags_tag_updateTag_deleteTag() async throws {
		let created = try await client.request(.addTag(TagResource(label: "integration-test-tag")))

		let id = try #require(created.id)
		#expect(created.label == "integration-test-tag")

		let tags = try await client.request(.tags)
		#expect(tags.contains(where: { $0.id == id }))

		let fetched = try await client.request(.tag(id: id))
		#expect(fetched.id == id)

		let updated = try await client.request(
			.updateTag(id: id, TagResource(id: id, label: "integration-test-tag-renamed")))
		#expect(updated.label == "integration-test-tag-renamed")

		try await client.request(.deleteTag(id: id))

		let remaining = try await client.request(.tags)
		#expect(!remaining.contains(where: { $0.id == id }))
	}
}
