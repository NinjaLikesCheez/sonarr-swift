import Sonarr
import Testing

@Suite("ImportList Requests", .serialized)
struct ImportListRequestsTests {
	// The schema endpoint returns a preset per implementation with its default fields already populated -
	// start from that instead of guessing at field shapes, and only override what the test needs.
	private static func plexWatchlistPreset() async throws -> ImportListResource {
		let schemas = try await client.request(.importListSchema)
		return try #require(schemas.first(where: { $0.implementation == "PlexImport" }))
	}

	private static func makeImportList(
		named name: String,
		basedOn preset: ImportListResource,
		id: Int? = nil,
		enableAutomaticAdd: Bool = false,
		listOrder: Int = 0
	) -> ImportListResource {
		ImportListResource(
			id: id,
			name: name,
			fields: preset.fields,
			implementationName: preset.implementationName,
			implementation: preset.implementation,
			configContract: preset.configContract,
			infoLink: preset.infoLink,
			tags: [],
			enableAutomaticAdd: enableAutomaticAdd,
			searchForMissingEpisodes: false,
			shouldMonitor: .none,
			monitorNewItems: .none,
			qualityProfileId: 1,
			seriesType: .standard,
			seasonFolder: true,
			listType: preset.listType,
			listOrder: listOrder
		)
	}

	@Test
	func test_addImportList_importLists_importList_updateImportList_deleteImportList() async throws {
		let preset = try await Self.plexWatchlistPreset()

		let created = try await client.request(
			.addImportList(
				Self.makeImportList(named: "Integration Test List", basedOn: preset),
				forceSave: true
			)
		)

		let id = try #require(created.id)
		#expect(created.name == "Integration Test List")

		let importLists = try await client.request(.importLists)
		#expect(importLists.contains(where: { $0.id == id }))

		let fetched = try await client.request(.importList(id: id))
		#expect(fetched.id == id)

		let updated = try await client.request(
			.updateImportList(
				id: id,
				Self.makeImportList(
					named: "Integration Test List Renamed",
					basedOn: preset,
					id: id,
					listOrder: 1
				),
				forceSave: true
			)
		)
		#expect(updated.name == "Integration Test List Renamed")
		#expect(updated.listOrder == 1)

		try await client.request(.deleteImportList(id: id))

		let remaining = try await client.request(.importLists)
		#expect(!remaining.contains(where: { $0.id == id }))
	}

	@Test
	func test_updateImportLists_deleteImportLists() async throws {
		let preset = try await Self.plexWatchlistPreset()

		let first = try await client.request(
			.addImportList(
				Self.makeImportList(named: "Bulk Test List 1", basedOn: preset),
				forceSave: true
			)
		)
		let second = try await client.request(
			.addImportList(
				Self.makeImportList(named: "Bulk Test List 2", basedOn: preset),
				forceSave: true
			)
		)

		let firstID = try #require(first.id)
		let secondID = try #require(second.id)

		_ = try await client.request(
			.updateImportLists(ImportListBulkResource(ids: [firstID, secondID], qualityProfileId: 1))
		)

		try await client.request(.deleteImportLists(ImportListBulkResource(ids: [firstID, secondID])))

		let remaining = try await client.request(.importLists)
		#expect(!remaining.contains(where: { $0.id == firstID || $0.id == secondID }))
	}

	@Test
	func test_importListSchema() async throws {
		let schema = try await client.request(.importListSchema)

		#expect(!schema.isEmpty)
	}

	@Test
	func test_testAllImportLists() async throws {
		try await client.request(.testAllImportLists)
	}
}
