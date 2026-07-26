import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("Missing requests")
struct MissingRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	@Test func missingEpisodesRequestConstructionWithDefaults() {
		let request = SonarrRequest.missingEpisodes()

		#expect(request.method == .get)
		#expect(request.path == "api/v3/wanted/missing")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/wanted/missing")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(
			components?.queryItems == [
				URLQueryItem(name: "includeSeries", value: "false"),
				URLQueryItem(name: "includeImages", value: "false"),
				URLQueryItem(name: "monitored", value: "true"),
			]
		)
	}

	@Test func missingEpisodesRequestConstructionWithFilters() {
		let request = SonarrRequest.missingEpisodes(
			page: 2,
			pageSize: 25,
			sortKey: "airDateUtc",
			sortDirection: .descending,
			includeSeries: true,
			includeImages: true,
			monitored: false
		)

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/wanted/missing")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(
			components?.queryItems == [
				URLQueryItem(name: "includeSeries", value: "true"),
				URLQueryItem(name: "includeImages", value: "true"),
				URLQueryItem(name: "monitored", value: "false"),
				URLQueryItem(name: "page", value: "2"),
				URLQueryItem(name: "pageSize", value: "25"),
				URLQueryItem(name: "sortKey", value: "airDateUtc"),
				URLQueryItem(name: "sortDirection", value: "descending"),
			]
		)
	}

	@Test func missingEpisodeRequestConstruction() {
		let request = SonarrRequest.missingEpisode(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/wanted/missing/1")
	}

	@Test func missingEpisodesPagingResourceDecoding() throws {
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
						"episodeFileId": 0,
						"seasonNumber": 1,
						"episodeNumber": 3,
						"title": "Some Episode",
						"airDateUtc": "2024-01-01T12:00:00Z",
						"runtime": 30,
						"hasFile": false,
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
		#expect(page.records?.count == 1)

		let episode = try #require(page.records?.first)
		#expect(episode.id == 1)
		#expect(episode.seriesId == 5)
		#expect(episode.hasFile == false)
		#expect(episode.monitored == true)
	}
}
