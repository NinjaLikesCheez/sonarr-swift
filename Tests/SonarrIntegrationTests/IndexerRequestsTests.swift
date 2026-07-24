import Sonarr
import Testing

@Suite("Indexer Requests", .serialized)
struct IndexerRequestsTests {
	// The schema endpoint returns a preset per implementation with its default fields already populated -
	// start from that instead of guessing at field shapes, and only override what the test needs.
	private static func newznabPreset() async throws -> IndexerResource {
		let schemas = try await client.request(.indexerSchema)
		return try #require(schemas.first(where: { $0.implementation == "Newznab" }))
	}

	private static func makeIndexer(
		named name: String,
		basedOn preset: IndexerResource,
		id: Int? = nil,
		enableRss: Bool = false,
		priority: Int = 25
	) -> IndexerResource {
		IndexerResource(
			id: id,
			name: name,
			fields: preset.fields,
			implementationName: preset.implementationName,
			implementation: preset.implementation,
			configContract: preset.configContract,
			infoLink: preset.infoLink,
			tags: [],
			enableRss: enableRss,
			enableAutomaticSearch: false,
			enableInteractiveSearch: false,
			supportsRss: preset.supportsRss,
			supportsSearch: preset.supportsSearch,
			protocol: preset.protocol,
			priority: priority,
			seasonSearchMaximumSingleEpisodeAge: 0,
			downloadClientId: 0
		)
	}

	@Test
	func test_addIndexer_indexers_indexer_updateIndexer_deleteIndexer() async throws {
		let preset = try await Self.newznabPreset()

		let created = try await client.request(
			.addIndexer(
				Self.makeIndexer(named: "Integration Test Indexer", basedOn: preset),
				forceSave: true
			)
		)

		let id = try #require(created.id)
		#expect(created.name == "Integration Test Indexer")

		let indexers = try await client.request(.indexers)
		#expect(indexers.contains(where: { $0.id == id }))

		let fetched = try await client.request(.indexer(id: id))
		#expect(fetched.id == id)

		let updated = try await client.request(
			.updateIndexer(
				id: id,
				Self.makeIndexer(
					named: "Integration Test Indexer Renamed",
					basedOn: preset,
					id: id,
					priority: 30
				),
				forceSave: true
			)
		)
		#expect(updated.name == "Integration Test Indexer Renamed")
		#expect(updated.priority == 30)

		try await client.request(.deleteIndexer(id: id))

		let remaining = try await client.request(.indexers)
		#expect(!remaining.contains(where: { $0.id == id }))
	}

	@Test
	func test_updateIndexers_deleteIndexers() async throws {
		let preset = try await Self.newznabPreset()

		let first = try await client.request(
			.addIndexer(
				Self.makeIndexer(named: "Bulk Test Indexer 1", basedOn: preset),
				forceSave: true
			)
		)
		let second = try await client.request(
			.addIndexer(
				Self.makeIndexer(named: "Bulk Test Indexer 2", basedOn: preset),
				forceSave: true
			)
		)

		let firstID = try #require(first.id)
		let secondID = try #require(second.id)

		let updated = try await client.request(
			.updateIndexers(IndexerBulkResource(ids: [firstID, secondID], priority: 40))
		)
		#expect(updated.count == 2)

		try await client.request(.deleteIndexers(IndexerBulkResource(ids: [firstID, secondID])))

		let remaining = try await client.request(.indexers)
		#expect(!remaining.contains(where: { $0.id == firstID || $0.id == secondID }))
	}

	@Test
	func test_indexerSchema() async throws {
		let schema = try await client.request(.indexerSchema)

		#expect(!schema.isEmpty)
	}

	@Test
	func test_testAllIndexers() async throws {
		try await client.request(.testAllIndexers)
	}
}
