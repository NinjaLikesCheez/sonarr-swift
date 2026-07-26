import Sonarr
import Testing

@Suite("Series Requests", .serialized)
struct SeriesRequestsTests {
	// .series() is already exercised (and its results asserted on) by the lifecycle test below, both
	// before adding and after deleting the test series - a standalone smoke test here would only ever
	// assert that the endpoint decodes, which that test already establishes as a side effect.

	@Test
	func test_addSeries_series_seriesById_updateSeries_deleteSeries() async throws {
		let qualityProfiles = try await client.request(.qualityProfiles)
		let qualityProfile = try #require(qualityProfiles.first)
		let qualityProfileId = try #require(qualityProfile.id)

		// Sonarr's RootFolderExistsValidator requires the path to be a *registered* root folder,
		// not just an existing directory - /media exists in the container but isn't registered
		// by default, so it has to be added first.
		let rootFolder = try await client.request(.addRootFolder(RootFolderResource(path: "/media")))
		let rootFolderId = try #require(rootFolder.id)

		let created = try await client.request(
			.addSeries(
				SeriesResource(
					title: "The Simpsons",
					qualityProfileId: qualityProfileId,
					monitored: false,
					tvdbId: 71663,
					rootFolderPath: "/media",
					addOptions: AddSeriesOptions(monitor: MonitorTypes.none, searchForMissingEpisodes: false)
				)
			)
		)

		let id = try #require(created.id)
		#expect(created.title == "The Simpsons")

		let allSeries = try await client.request(.series())
		#expect(allSeries.contains(where: { $0.id == id }))

		let fetched = try await client.request(.series(id: id))
		#expect(fetched.id == id)

		let folder = try await client.request(.seriesFolder(id: id))
		#expect(!folder.folder.isEmpty)

		let updated = try await client.request(
			.updateSeries(
				id: id,
				SeriesResource(
					id: id,
					title: created.title,
					path: created.path,
					qualityProfileId: created.qualityProfileId,
					monitored: true,
					tvdbId: created.tvdbId,
					rootFolderPath: created.rootFolderPath
				)
			)
		)
		#expect(updated.monitored == true)

		try await client.request(.deleteSeries(id: id, deleteFiles: false))

		let remaining = try await client.request(.series())
		#expect(!remaining.contains(where: { $0.id == id }))

		try await client.request(.deleteRootFolder(id: rootFolderId))
	}

	@Test
	func test_importSeries_empty() async throws {
		let imported = try await client.request(.importSeries([]))

		#expect(imported.isEmpty)
	}

	@Test
	func test_lookupSeries() async throws {
		let results = try await client.request(.lookupSeries(term: "The Simpsons"))

		#expect(!results.isEmpty)
	}

	@Test
	func test_editSeries_deleteSeriesInBulk() async throws {
		let qualityProfiles = try await client.request(.qualityProfiles)
		let qualityProfile = try #require(qualityProfiles.first)
		let qualityProfileId = try #require(qualityProfile.id)

		let rootFolder = try await client.request(.addRootFolder(RootFolderResource(path: "/media")))
		let rootFolderId = try #require(rootFolder.id)

		let created = try await client.request(
			.addSeries(
				SeriesResource(
					title: "Futurama",
					qualityProfileId: qualityProfileId,
					monitored: false,
					tvdbId: 73871,
					rootFolderPath: "/media",
					addOptions: AddSeriesOptions(monitor: MonitorTypes.none, searchForMissingEpisodes: false)
				)
			)
		)
		let id = try #require(created.id)

		try await client.request(.editSeries(SeriesEditorResource(seriesIds: [id], monitored: true)))

		// The series editor applies its changes via an async command, so the write isn't
		// guaranteed to be visible immediately - poll briefly rather than asserting on the very
		// next read.
		let edited = try await poll {
			try await client.request(.series(id: id))
		} until: {
			$0.monitored == true
		}
		#expect(edited.monitored == true)

		try await client.request(.deleteSeries(inBulk: SeriesEditorResource(seriesIds: [id], deleteFiles: false)))

		let remaining = try await poll {
			try await client.request(.series())
		} until: {
			!$0.contains(where: { $0.id == id })
		}
		#expect(!remaining.contains(where: { $0.id == id }))

		try await client.request(.deleteRootFolder(id: rootFolderId))
	}
}
