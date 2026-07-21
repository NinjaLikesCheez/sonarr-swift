import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("Episode requests")
struct EpisodeRequestsTests {
	let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleEpisode: EpisodeResource {
		EpisodeResource(
			id: 1,
			seriesId: 5,
			tvdbId: 100,
			episodeFileId: 9,
			seasonNumber: 1,
			episodeNumber: 3,
			title: "Some Episode",
			airDate: "2024-01-01",
			airDateUtc: nil,
			lastSearchTime: nil,
			runtime: 30,
			finaleType: nil,
			overview: nil,
			episodeFile: nil,
			hasFile: true,
			monitored: true,
			absoluteEpisodeNumber: nil,
			sceneAbsoluteEpisodeNumber: nil,
			sceneEpisodeNumber: nil,
			sceneSeasonNumber: nil,
			unverifiedSceneNumbering: false,
			endTime: nil,
			grabDate: nil,
			series: nil,
			images: nil,
			grabbed: false
		)
	}

	@Test func episodesRequestConstructionWithDefaults() {
		let request = SonarrRequest.episodes()

		#expect(request.method == .get)
		#expect(request.path == "api/v3/episode")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/episode")!)
		let prepared = request.prepare(urlRequest)

		#expect(
			prepared.url?.absoluteString
				== "http://localhost:8989/api/v3/episode?includeSeries=false&includeEpisodeFile=false&includeImages=false"
		)
	}

	@Test func episodesRequestConstructionWithFilters() {
		let request = SonarrRequest.episodes(
			seriesId: 5,
			seasonNumber: 1,
			episodeIds: [1, 2],
			episodeFileId: 9,
			includeSeries: true,
			includeEpisodeFile: true,
			includeImages: true
		)

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/episode")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(
			components?.queryItems == [
				URLQueryItem(name: "includeSeries", value: "true"),
				URLQueryItem(name: "includeEpisodeFile", value: "true"),
				URLQueryItem(name: "includeImages", value: "true"),
				URLQueryItem(name: "seriesId", value: "5"),
				URLQueryItem(name: "seasonNumber", value: "1"),
				URLQueryItem(name: "episodeIds", value: "1"),
				URLQueryItem(name: "episodeIds", value: "2"),
				URLQueryItem(name: "episodeFileId", value: "9"),
			]
		)
	}

	@Test func episodeRequestConstruction() {
		let request = SonarrRequest.episode(id: 42)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/episode/42")
	}

	@Test func updateEpisodeRequestConstruction() throws {
		let request = SonarrRequest.updateEpisode(id: 1, sampleEpisode)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/episode/1")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(EpisodeResource.self, from: try body.encode())
		#expect(decoded == sampleEpisode)
	}

	@Test func updateEpisodesMonitoredRequestConstruction() throws {
		let episodesMonitored = EpisodesMonitoredResource(episodeIds: [1, 2, 3], monitored: true)
		let request = SonarrRequest.updateEpisodesMonitored(episodesMonitored, includeImages: true)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/episode/monitor")

		let prepared = request.prepare(URLRequest(url: URL(string: "http://localhost:8989/api/v3/episode/monitor")!))
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == [URLQueryItem(name: "includeImages", value: "true")])

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(EpisodesMonitoredResourceFixture.self, from: try body.encode())
		#expect(decoded.episodeIds == [1, 2, 3])
		#expect(decoded.monitored == true)
	}

	@Test func updateEpisodesMonitoredRequestConstructionDefaultsIncludeImagesFalse() {
		let request = SonarrRequest.updateEpisodesMonitored(EpisodesMonitoredResource(monitored: false))

		let prepared = request.prepare(URLRequest(url: URL(string: "http://localhost:8989/api/v3/episode/monitor")!))
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == [URLQueryItem(name: "includeImages", value: "false")])
	}

	@Test func episodeDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"seriesId": 5,
				"tvdbId": 100,
				"episodeFileId": 9,
				"seasonNumber": 1,
				"episodeNumber": 3,
				"title": "Some Episode",
				"airDateUtc": "2024-01-01T12:00:00Z",
				"runtime": 30,
				"hasFile": true,
				"monitored": true,
				"unverifiedSceneNumbering": false,
				"grabbed": false
			}
			"""#.utf8
		)

		let episode = try client.decoder.decode(EpisodeResource.self, from: json)

		#expect(episode.id == 1)
		#expect(episode.seriesId == 5)
		#expect(episode.title == "Some Episode")
		#expect(episode.monitored == true)
	}

	@Test func episodesListDecoding() throws {
		let json = Data(
			#"""
			[
				{
					"id": 1,
					"seriesId": 5,
					"tvdbId": 100,
					"episodeFileId": 9,
					"seasonNumber": 1,
					"episodeNumber": 3,
					"title": "Some Episode",
					"airDateUtc": "2024-01-01T12:00:00Z",
					"runtime": 30,
					"hasFile": true,
					"monitored": true,
					"unverifiedSceneNumbering": false,
					"grabbed": false
				}
			]
			"""#.utf8
		)

		let episodes = try client.decoder.decode([EpisodeResource].self, from: json)

		#expect(episodes.count == 1)
		#expect(episodes.first?.id == 1)
	}
}

private struct EpisodesMonitoredResourceFixture: Decodable {
	let episodeIds: [Int]?
	let monitored: Bool
}
