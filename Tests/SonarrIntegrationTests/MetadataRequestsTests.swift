import Sonarr
import Testing

@Suite("Metadata Requests", .serialized)
struct MetadataRequestsTests {
	// The schema endpoint returns a preset per implementation with its default fields already populated -
	// start from that instead of guessing at field shapes, and only override what the test needs.
	private static func firstPreset() async throws -> MetadataResource {
		let schemas = try await client.request(.metadataConsumerSchema)
		return try #require(schemas.first)
	}

	private static func makeMetadataConsumer(
		named name: String,
		basedOn preset: MetadataResource,
		id: Int? = nil,
		enable: Bool = false
	) -> MetadataResource {
		MetadataResource(
			id: id,
			name: name,
			fields: preset.fields,
			implementationName: preset.implementationName,
			implementation: preset.implementation,
			configContract: preset.configContract,
			infoLink: preset.infoLink,
			tags: [],
			enable: enable
		)
	}

	@Test
	func test_addMetadataConsumer_metadataConsumers_metadataConsumer_updateMetadataConsumer_deleteMetadataConsumer()
		async throws
	{
		let preset = try await Self.firstPreset()

		let created = try await client.request(
			.addMetadataConsumer(
				Self.makeMetadataConsumer(named: "Integration Test Consumer", basedOn: preset),
				forceSave: true
			)
		)

		let id = try #require(created.id)
		#expect(created.name == "Integration Test Consumer")

		let metadataConsumers = try await client.request(.metadataConsumers)
		#expect(metadataConsumers.contains(where: { $0.id == id }))

		let fetched = try await client.request(.metadataConsumer(id: id))
		#expect(fetched.id == id)

		let updated = try await client.request(
			.updateMetadataConsumer(
				id: id,
				Self.makeMetadataConsumer(
					named: "Integration Test Consumer Renamed",
					basedOn: preset,
					id: id,
					enable: true
				),
				forceSave: true
			)
		)
		#expect(updated.name == "Integration Test Consumer Renamed")
		#expect(updated.enable == true)

		try await client.request(.deleteMetadataConsumer(id: id))

		let remaining = try await client.request(.metadataConsumers)
		#expect(!remaining.contains(where: { $0.id == id }))
	}

	@Test
	func test_metadataConsumerSchema() async throws {
		let schema = try await client.request(.metadataConsumerSchema)

		#expect(!schema.isEmpty)
	}

	@Test
	func test_testAllMetadataConsumers() async throws {
		try await client.request(.testAllMetadataConsumers)
	}
}
