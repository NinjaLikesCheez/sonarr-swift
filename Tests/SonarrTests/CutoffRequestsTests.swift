import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("Cutoff requests")
struct CutoffRequestsTests {
	let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	@Test func cutoffRequestConstructionWithDefaults() {
		let request = SonarrRequest.cutoff()

		#expect(request.method == .get)
		#expect(request.path == "api/v3/wanted/cutoff")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/wanted/cutoff")!)
		let prepared = request.prepare(urlRequest)

		#expect(
			prepared.url?.absoluteString
				== "http://localhost:8989/api/v3/wanted/cutoff?includeSeries=false&includeEpisodeFile=false&includeImages=false"
		)
	}

	@Test func cutoffRequestConstructionWithFilters() {
		let request = SonarrRequest.cutoff(
			page: 2,
			pageSize: 25,
			sortKey: "airDateUtc",
			sortDirection: "descending",
			includeSeries: true,
			includeEpisodeFile: true,
			includeImages: true,
			monitored: true
		)

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/wanted/cutoff")!)
		let prepared = request.prepare(urlRequest)

		#expect(
			prepared.url?.absoluteString
				== "http://localhost:8989/api/v3/wanted/cutoff?includeSeries=true&includeEpisodeFile=true&includeImages=true&page=2&pageSize=25&sortKey=airDateUtc&sortDirection=descending&monitored=true"
		)
	}

	@Test func cutoffEntryRequestConstruction() {
		let request = SonarrRequest.cutoffEntry(id: 42)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/wanted/cutoff/42")
	}

	@Test func cutoffPageDecoding() throws {
		let json = Data(
			#"""
			{
				"page": 1,
				"pageSize": 10,
				"sortKey": "airDateUtc",
				"sortDirection": "descending",
				"totalRecords": 1,
				"records": [
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
			}
			"""#.utf8
		)

		let page = try client.decoder.decode(PagingResource<EpisodeResource>.self, from: json)

		#expect(page.page == 1)
		#expect(page.totalRecords == 1)
		#expect(page.records.count == 1)

		let episode = try #require(page.records.first)
		#expect(episode.id == 1)
		#expect(episode.seriesId == 5)
		#expect(episode.title == "Some Episode")
		#expect(episode.monitored == true)
	}

	@Test func cutoffEntryDecoding() throws {
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
	}
}
