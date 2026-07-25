import Sonarr
import Testing

@Suite("Series Requests", .serialized)
struct SeriesRequestsTests {
	@Test
	func test_series() async throws {
		try await client.request(.series())
	}

	@Test
	func test_addSeries_series_seriesById_updateSeries_deleteSeries() async throws {
		let qualityProfiles = try await client.request(.qualityProfiles)
		let qualityProfile = try #require(qualityProfiles.first)
		let qualityProfileId = try #require(qualityProfile.id)

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
	}
}
