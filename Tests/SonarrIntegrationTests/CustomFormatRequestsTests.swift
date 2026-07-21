import Sonarr
import Testing

@Suite("CustomFormat Requests", .serialized)
struct CustomFormatRequestsTests {
	@Test
	func test_addCustomFormat_customFormats_customFormat_updateCustomFormat_deleteCustomFormat() async throws {
		let created = try await client.request(
			.addCustomFormat(
				CustomFormatResource(
					name: "Integration Test Format",
					includeCustomFormatWhenRenaming: false,
					specifications: []
				)
			)
		)

		let id = try #require(created.id)
		#expect(created.name == "Integration Test Format")

		let customFormats = try await client.request(.customFormats)
		#expect(customFormats.contains(where: { $0.id == id }))

		let fetched = try await client.request(.customFormat(id: id))
		#expect(fetched.id == id)

		let updated = try await client.request(
			.updateCustomFormat(
				id: id,
				CustomFormatResource(
					id: id,
					name: "Integration Test Format Renamed",
					includeCustomFormatWhenRenaming: false,
					specifications: []
				)
			)
		)
		#expect(updated.name == "Integration Test Format Renamed")

		try await client.request(.deleteCustomFormat(id: id))

		let remaining = try await client.request(.customFormats)
		#expect(!remaining.contains(where: { $0.id == id }))
	}

	@Test
	func test_updateCustomFormats_deleteCustomFormats() async throws {
		let first = try await client.request(
			.addCustomFormat(
				CustomFormatResource(name: "Bulk Test Format 1", includeCustomFormatWhenRenaming: false, specifications: [])
			)
		)
		let second = try await client.request(
			.addCustomFormat(
				CustomFormatResource(name: "Bulk Test Format 2", includeCustomFormatWhenRenaming: false, specifications: [])
			)
		)

		let firstID = try #require(first.id)
		let secondID = try #require(second.id)

		_ = try await client.request(
			.updateCustomFormats(ids: [firstID, secondID], includeCustomFormatWhenRenaming: true)
		)

		try await client.request(.deleteCustomFormats(ids: [firstID, secondID]))

		let remaining = try await client.request(.customFormats)
		#expect(!remaining.contains(where: { $0.id == firstID || $0.id == secondID }))
	}

	@Test
	func test_customFormatSchema() async throws {
		let schema = try await client.request(.customFormatSchema)

		#expect(!schema.isEmpty)
	}
}
