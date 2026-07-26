import Sonarr
import Testing

@Suite("ImportListExclusion Requests", .serialized)
struct ImportListExclusionRequestsTests {
	@Test
	func test_addImportListExclusion_importListExclusion_updateImportListExclusion_deleteImportListExclusion()
		async throws
	{
		let created = try await client.request(
			.addImportListExclusion(ImportListExclusionResource(tvdbId: 12345, title: "Integration Test Show"))
		)

		let id = try #require(created.id)
		#expect(created.tvdbId == 12345)

		let fetched = try await client.request(.importListExclusion(id: id))
		#expect(fetched.id == id)

		let updated = try await client.request(
			.updateImportListExclusion(
				id: id,
				ImportListExclusionResource(id: id, tvdbId: 12345, title: "Integration Test Show Renamed")
			)
		)
		#expect(updated.title == "Integration Test Show Renamed")

		try await client.request(.deleteImportListExclusion(id: id))

		let remaining = try await client.request(.importListExclusions(pageSize: 1000))
		#expect(!(remaining.records ?? []).contains(where: { $0.id == id }))
	}

	@Test
	func test_importListExclusionsPaged() async throws {
		let page = try await client.request(.importListExclusions())

		#expect(page.page == 1)
	}

	@Test
	func test_deleteImportListExclusions_empty() async throws {
		try await client.request(.deleteImportListExclusions(ImportListExclusionBulkResource(ids: [])))
	}
}
