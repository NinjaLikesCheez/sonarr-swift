import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("Calendar requests")
struct CalendarRequestsTests {
	let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	@Test func calendarRequestConstructionWithDefaults() {
		let request = SonarrRequest.calendar()

		#expect(request.method == .get)
		#expect(request.path == "api/v3/calendar")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/calendar")!)
		let prepared = request.prepare(urlRequest)

		#expect(
			prepared.url?.absoluteString
				== "http://localhost:8989/api/v3/calendar?unmonitored=false&includeSeries=false&includeEpisodeFile=false&includeEpisodeImages=false"
		)
	}

	@Test func calendarRequestConstructionWithFilters() {
		let start = Date(timeIntervalSince1970: 1_704_110_400)  // 2024-01-01T12:00:00Z
		let end = Date(timeIntervalSince1970: 1_704_196_800)  // 2024-01-02T12:00:00Z

		let request = SonarrRequest.calendar(
			start: start,
			end: end,
			unmonitored: true,
			includeSeries: true,
			includeEpisodeFile: true,
			includeEpisodeImages: true,
			tags: [1, 2]
		)

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/calendar")!)
		let prepared = request.prepare(urlRequest)

		#expect(
			prepared.url?.absoluteString
				== "http://localhost:8989/api/v3/calendar?unmonitored=true&includeSeries=true&includeEpisodeFile=true&includeEpisodeImages=true&start=2024-01-01T12:00:00Z&end=2024-01-02T12:00:00Z&tags=1,2"
		)
	}

	@Test func calendarEntryRequestConstruction() {
		let request = SonarrRequest.calendarEntry(id: 42)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/calendar/42")
	}

	@Test func calendarDecoding() throws {
		let json = Data(
			#"""
			[
				{
					"id": 1,
					"seriesId": 5,
					"tvdbId": 100,
					"episodeFileId": 0,
					"seasonNumber": 1,
					"episodeNumber": 3,
					"title": "Some Episode",
					"airDate": "2024-01-01",
					"airDateUtc": "2024-01-01T12:00:00Z",
					"runtime": 30,
					"overview": "An episode.",
					"hasFile": false,
					"monitored": true,
					"unverifiedSceneNumbering": false,
					"grabbed": false
				}
			]
			"""#.utf8
		)

		let episodes = try client.decoder.decode([EpisodeResource].self, from: json)

		#expect(episodes.count == 1)

		let episode = try #require(episodes.first)
		#expect(episode.id == 1)
		#expect(episode.seriesId == 5)
		#expect(episode.tvdbId == 100)
		#expect(episode.seasonNumber == 1)
		#expect(episode.episodeNumber == 3)
		#expect(episode.title == "Some Episode")
		#expect(episode.airDate == "2024-01-01")
		#expect(episode.runtime == 30)
		#expect(episode.overview == "An episode.")
		#expect(episode.hasFile == false)
		#expect(episode.monitored == true)
		#expect(episode.grabbed == false)
		#expect(episode.series == nil)
		#expect(episode.episodeFile == nil)
		#expect(episode.images == nil)
	}

	@Test func calendarEntryDecodingWithSeriesAndEpisodeFileAndImages() throws {
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
				"grabbed": true,
				"series": {
					"id": 5,
					"title": "Some Show",
					"year": 2020,
					"qualityProfileId": 1,
					"monitored": true,
					"tvdbId": 200
				},
				"episodeFile": {
					"id": 9,
					"seriesId": 5,
					"seasonNumber": 1,
					"size": 1024,
					"dateAdded": "2024-01-01T13:00:00Z",
					"quality": {
						"quality": {"id": 3, "name": "WEBDL-1080p", "source": "web", "resolution": 1080},
						"revision": {"version": 1, "real": 0, "isRepack": false}
					},
					"customFormatScore": 0,
					"releaseType": "singleEpisode",
					"qualityCutoffNotMet": false
				},
				"images": [
					{"coverType": "poster", "url": "/mediacover/5/poster.jpg", "remoteUrl": "https://example.com/poster.jpg"}
				]
			}
			"""#.utf8
		)

		let episode = try client.decoder.decode(EpisodeResource.self, from: json)

		#expect(episode.series?.id == 5)
		#expect(episode.series?.title == "Some Show")
		#expect(episode.episodeFile?.id == 9)
		#expect(episode.episodeFile?.quality.quality.name == "WEBDL-1080p")
		#expect(episode.images?.first?.coverType == .poster)
		#expect(episode.images?.first?.url == "/mediacover/5/poster.jpg")
	}
}
