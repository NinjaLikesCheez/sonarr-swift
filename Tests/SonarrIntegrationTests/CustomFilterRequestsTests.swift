import Sonarr
import Testing

@Suite("CustomFilter Requests", .serialized)
struct CustomFilterRequestsTests {
	@Test
	func test_addCustomFilter_customFilters_customFilter_updateCustomFilter_deleteCustomFilter() async throws {
		let created = try await client.request(
			.addCustomFilter(
				CustomFilterResource(
					type: "series",
					label: "Integration Test Filter",
					filters: [["key": .string("status"), "value": .string("continuing")]]
				)
			)
		)

		let id = try #require(created.id)
		#expect(created.label == "Integration Test Filter")

		let customFilters = try await client.request(.customFilters)
		#expect(customFilters.contains(where: { $0.id == id }))

		let fetched = try await client.request(.customFilter(id: id))
		#expect(fetched.id == id)

		let updated = try await client.request(
			.updateCustomFilter(
				id: id,
				CustomFilterResource(
					id: id,
					type: "series",
					label: "Integration Test Filter Renamed",
					filters: [["key": .string("status"), "value": .string("continuing")]]
				)
			)
		)
		#expect(updated.label == "Integration Test Filter Renamed")

		try await client.request(.deleteCustomFilter(id: id))

		let remaining = try await client.request(.customFilters)
		#expect(!remaining.contains(where: { $0.id == id }))
	}
}
