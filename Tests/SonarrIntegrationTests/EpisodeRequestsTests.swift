import Sonarr
import Testing

@Suite("Episode Requests", .serialized)
struct EpisodeRequestsTests {
	@Test
	func test_episodes_requiresSeriesIdOrEpisodeIds() async throws {
		// Sonarr rejects unfiltered requests - there's no Series tag support yet to seed a real series to
		// filter by, so this only exercises the validation path.
		await #expect(throws: (Sonarr.Error).self) {
			try await client.request(.episodes())
		}
	}

	@Test
	func test_episode_notFound() async throws {
		await #expect(throws: (Sonarr.Error).self) {
			try await client.request(.episode(id: Int.max))
		}
	}

	@Test
	func test_updateEpisode_notFound() async throws {
		await #expect(throws: (Sonarr.Error).self) {
			try await client.request(
				.updateEpisode(
					id: Int.max,
					EpisodeResource(
						id: Int.max,
						seriesId: 1,
						tvdbId: 1,
						episodeFileId: 0,
						seasonNumber: 1,
						episodeNumber: 1,
						runtime: 30,
						hasFile: false,
						monitored: true,
						unverifiedSceneNumbering: false,
						grabbed: false
					)
				)
			)
		}
	}

	@Test
	func test_updateEpisodesMonitored_empty() async throws {
		// No series exist to pull real episode identifiers from yet - an empty list is still a valid request
		// and exercises the request/response shape without depending on seeded data.
		try await client.request(.updateEpisodesMonitored(EpisodesMonitoredResource(episodeIds: [], monitored: true)))
	}
}
