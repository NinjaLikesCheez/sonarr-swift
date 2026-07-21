import Foundation
import Sonarr
import Testing

@Suite("CustomFormat Requests", .serialized)
struct CustomFormatRequestsTests {
	// `Field` has no public initializer, so build it the same way the wire format does: decode it.
	private static func releaseTitleSpecification(value: String) -> CustomFormatSpecificationSchema {
		let fieldJSON = Data(
			#"""
			[
				{
					"order": 0,
					"name": "value",
					"label": "Regular Expression",
					"value": "\#(value)",
					"type": "textbox",
					"advanced": false,
					"privacy": "normal",
					"isFloat": false
				}
			]
			"""#.utf8
		)
		let fields = try! JSONDecoder().decode([Field].self, from: fieldJSON)

		return CustomFormatSpecificationSchema(
			name: "Release Title",
			implementation: "ReleaseTitleSpecification",
			implementationName: "Release Title",
			infoLink: nil,
			negate: false,
			required: true,
			fields: fields
		)
	}

	@Test
	func test_addCustomFormat_customFormats_customFormat_updateCustomFormat_deleteCustomFormat() async throws {
		let created = try await client.request(
			.addCustomFormat(
				CustomFormatResource(
					name: "Integration Test Format",
					includeCustomFormatWhenRenaming: false,
					specifications: [Self.releaseTitleSpecification(value: "test")]
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
					specifications: [Self.releaseTitleSpecification(value: "test")]
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
				CustomFormatResource(
					name: "Bulk Test Format 1",
					includeCustomFormatWhenRenaming: false,
					specifications: [Self.releaseTitleSpecification(value: "test1")]
				)
			)
		)
		let second = try await client.request(
			.addCustomFormat(
				CustomFormatResource(
					name: "Bulk Test Format 2",
					includeCustomFormatWhenRenaming: false,
					specifications: [Self.releaseTitleSpecification(value: "test2")]
				)
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
