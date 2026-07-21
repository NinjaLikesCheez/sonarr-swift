import Sonarr
import Testing

@Suite("DownloadClient Requests", .serialized)
struct DownloadClientRequestsTests {
	// The schema endpoint returns a preset per implementation with its default fields already populated -
	// start from that instead of guessing at field shapes, and only override what the test needs.
	private static func transmissionPreset() async throws -> DownloadClientResource {
		let schemas = try await client.request(.downloadClientSchema)
		return try #require(schemas.first(where: { $0.implementation == "Transmission" }))
	}

	private static func makeDownloadClient(
		named name: String,
		basedOn preset: DownloadClientResource,
		id: Int? = nil,
		enable: Bool = false,
		priority: Int = 1
	) -> DownloadClientResource {
		DownloadClientResource(
			id: id,
			name: name,
			fields: preset.fields,
			implementationName: preset.implementationName,
			implementation: preset.implementation,
			configContract: preset.configContract,
			infoLink: preset.infoLink,
			tags: [],
			enable: enable,
			protocol: preset.protocol,
			priority: priority,
			removeCompletedDownloads: false,
			removeFailedDownloads: false
		)
	}

	@Test
	func test_addDownloadClient_downloadClients_downloadClient_updateDownloadClient_deleteDownloadClient() async throws {
		let preset = try await Self.transmissionPreset()

		let created = try await client.request(
			.addDownloadClient(
				Self.makeDownloadClient(named: "Integration Test Client", basedOn: preset),
				forceSave: true
			)
		)

		let id = try #require(created.id)
		#expect(created.name == "Integration Test Client")

		let downloadClients = try await client.request(.downloadClients)
		#expect(downloadClients.contains(where: { $0.id == id }))

		let fetched = try await client.request(.downloadClient(id: id))
		#expect(fetched.id == id)

		let updated = try await client.request(
			.updateDownloadClient(
				id: id,
				Self.makeDownloadClient(
					named: "Integration Test Client Renamed",
					basedOn: preset,
					id: id,
					priority: 2
				),
				forceSave: true
			)
		)
		#expect(updated.name == "Integration Test Client Renamed")
		#expect(updated.priority == 2)

		try await client.request(.deleteDownloadClient(id: id))

		let remaining = try await client.request(.downloadClients)
		#expect(!remaining.contains(where: { $0.id == id }))
	}

	@Test
	func test_updateDownloadClients_deleteDownloadClients() async throws {
		let preset = try await Self.transmissionPreset()

		let first = try await client.request(
			.addDownloadClient(
				Self.makeDownloadClient(named: "Bulk Test Client 1", basedOn: preset),
				forceSave: true
			)
		)
		let second = try await client.request(
			.addDownloadClient(
				Self.makeDownloadClient(named: "Bulk Test Client 2", basedOn: preset),
				forceSave: true
			)
		)

		let firstID = try #require(first.id)
		let secondID = try #require(second.id)

		_ = try await client.request(
			.updateDownloadClients(DownloadClientBulkResource(ids: [firstID, secondID], priority: 3))
		)

		try await client.request(.deleteDownloadClients(DownloadClientBulkResource(ids: [firstID, secondID])))

		let remaining = try await client.request(.downloadClients)
		#expect(!remaining.contains(where: { $0.id == firstID || $0.id == secondID }))
	}

	@Test
	func test_downloadClientSchema() async throws {
		let schema = try await client.request(.downloadClientSchema)

		#expect(!schema.isEmpty)
	}

	@Test
	func test_testAllDownloadClients() async throws {
		try await client.request(.testAllDownloadClients)
	}
}
