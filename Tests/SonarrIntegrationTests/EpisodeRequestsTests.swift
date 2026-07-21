import Sonarr
import Testing

@Suite("Episode Requests", .serialized)
struct EpisodeRequestsTests {
	@Test
	func test_episodes() async throws {
		let episodes = try await client.request(.episodes())

		#expect(!episodes.isEmpty)
	}

	@Test
	func test_episode_updateEpisode() async throws {
		let episodes = try await client.request(.episodes())
		let episode = try #require(episodes.first)

		let fetched = try await client.request(.episode(id: episode.id))
		#expect(fetched.id == episode.id)

		let updated = try await client.request(
			.updateEpisode(
				id: episode.id,
				EpisodeResource(
					id: episode.id,
					seriesId: episode.seriesId,
					tvdbId: episode.tvdbId,
					episodeFileId: episode.episodeFileId,
					seasonNumber: episode.seasonNumber,
					episodeNumber: episode.episodeNumber,
					title: episode.title,
					airDate: episode.airDate,
					airDateUtc: episode.airDateUtc,
					lastSearchTime: episode.lastSearchTime,
					runtime: episode.runtime,
					finaleType: episode.finaleType,
					overview: episode.overview,
					episodeFile: episode.episodeFile,
					hasFile: episode.hasFile,
					monitored: !episode.monitored,
					absoluteEpisodeNumber: episode.absoluteEpisodeNumber,
					sceneAbsoluteEpisodeNumber: episode.sceneAbsoluteEpisodeNumber,
					sceneEpisodeNumber: episode.sceneEpisodeNumber,
					sceneSeasonNumber: episode.sceneSeasonNumber,
					unverifiedSceneNumbering: episode.unverifiedSceneNumbering,
					endTime: episode.endTime,
					grabDate: episode.grabDate,
					series: episode.series,
					images: episode.images,
					grabbed: episode.grabbed
				)
			)
		)

		#expect(updated.monitored == !episode.monitored)
	}

	@Test
	func test_updateEpisodesMonitored() async throws {
		let episodes = try await client.request(.episodes())
		let episode = try #require(episodes.first)

		try await client.request(
			.updateEpisodesMonitored(EpisodesMonitoredResource(episodeIds: [episode.id], monitored: !episode.monitored))
		)

		let fetched = try await client.request(.episode(id: episode.id))
		#expect(fetched.monitored == !episode.monitored)
	}
}
