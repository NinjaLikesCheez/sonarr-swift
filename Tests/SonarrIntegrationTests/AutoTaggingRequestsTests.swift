import Sonarr
import Testing

private func createTag(label: String) async throws -> Int {
	let tag = try await client.request(.addTag(TagResource(label: label)))
	return try #require(tag.id)
}

private func deleteTag(id: Int) async throws {
	try await client.request(.deleteTag(id: id))
}

@Suite("AutoTagging Requests", .serialized)
struct AutoTaggingRequestsTests {
	@Test
	func test_autoTaggingSchema() async throws {
		let schema = try await client.request(.autoTaggingSchema)
		#expect(!schema.isEmpty)
	}

	@Test
	func test_addAutoTagging_autoTaggings_autoTagging_updateAutoTagging_deleteAutoTagging() async throws {
		let schema = try await client.request(.autoTaggingSchema)
		let template = try #require(schema.first(where: { $0.implementation == "SeriesTypeSpecification" }))
		let specification = AutoTaggingSpecificationSchema(
			name: "Is Anime",
			implementation: template.implementation,
			implementationName: template.implementationName,
			negate: template.negate,
			required: template.required,
			fields: template.fields
		)

		let tagID = try await createTag(label: "integration-test-autotagging")

		let created = try await client.request(
			.addAutoTagging(
				AutoTaggingResource(
					name: "Integration Test Auto Tag",
					removeTagsAutomatically: false,
					tags: [tagID],
					specifications: [specification]
				)
			)
		)

		let id = try #require(created.id)
		#expect(created.name == "Integration Test Auto Tag")

		let autoTaggings = try await client.request(.autoTaggings)
		#expect(autoTaggings.contains(where: { $0.id == id }))

		let fetched = try await client.request(.autoTagging(id: id))
		#expect(fetched.id == id)

		let updated = try await client.request(
			.updateAutoTagging(
				id: id,
				AutoTaggingResource(
					id: id,
					name: "Integration Test Auto Tag Renamed",
					removeTagsAutomatically: false,
					tags: [tagID],
					specifications: [specification]
				)
			)
		)
		#expect(updated.name == "Integration Test Auto Tag Renamed")

		try await client.request(.deleteAutoTagging(id: id))

		let remaining = try await client.request(.autoTaggings)
		#expect(!remaining.contains(where: { $0.id == id }))

		try await deleteTag(id: tagID)
	}
}
