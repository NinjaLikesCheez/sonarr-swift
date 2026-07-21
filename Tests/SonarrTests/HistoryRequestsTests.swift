import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("History requests")
struct HistoryRequestsTests {
	let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	@Test func historyRequestConstructionWithDefaults() {
		let request = SonarrRequest.history()

		#expect(request.method == .get)
		#expect(request.path == "api/v3/history")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/history")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(
			components?.queryItems == [
				URLQueryItem(name: "includeSeries", value: "false"),
				URLQueryItem(name: "includeEpisode", value: "false"),
			]
		)
	}

	@Test func historyRequestConstructionWithFilters() {
		let request = SonarrRequest.history(
			page: 2,
			pageSize: 25,
			sortKey: "date",
			sortDirection: "descending",
			includeSeries: true,
			includeEpisode: true,
			eventTypes: [.grabbed, .downloadFailed],
			episodeId: 7,
			downloadId: "abc123",
			seriesIds: [1, 2],
			languages: [1],
			quality: [3]
		)

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/history")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(
			components?.queryItems == [
				URLQueryItem(name: "includeSeries", value: "true"),
				URLQueryItem(name: "includeEpisode", value: "true"),
				URLQueryItem(name: "page", value: "2"),
				URLQueryItem(name: "pageSize", value: "25"),
				URLQueryItem(name: "sortKey", value: "date"),
				URLQueryItem(name: "sortDirection", value: "descending"),
				URLQueryItem(name: "episodeId", value: "7"),
				URLQueryItem(name: "downloadId", value: "abc123"),
				URLQueryItem(name: "eventType", value: "1"),
				URLQueryItem(name: "eventType", value: "4"),
				URLQueryItem(name: "seriesIds", value: "1"),
				URLQueryItem(name: "seriesIds", value: "2"),
				URLQueryItem(name: "languages", value: "1"),
				URLQueryItem(name: "quality", value: "3"),
			]
		)
	}

	@Test func historySinceRequestConstructionWithDefaults() {
		let request = SonarrRequest.historySince()

		#expect(request.method == .get)
		#expect(request.path == "api/v3/history/since")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/history/since")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(
			components?.queryItems == [
				URLQueryItem(name: "includeSeries", value: "false"),
				URLQueryItem(name: "includeEpisode", value: "false"),
			]
		)
	}

	@Test func historySinceRequestConstructionWithFilters() {
		let request = SonarrRequest.historySince(
			date: Date(timeIntervalSince1970: 1_704_110_400),
			eventType: .grabbed,
			includeSeries: true,
			includeEpisode: true
		)

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/history/since")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(
			components?.queryItems == [
				URLQueryItem(name: "includeSeries", value: "true"),
				URLQueryItem(name: "includeEpisode", value: "true"),
				URLQueryItem(name: "date", value: "2024-01-01T12:00:00Z"),
				URLQueryItem(name: "eventType", value: "grabbed"),
			]
		)
	}

	@Test func historyForSeriesRequestConstructionWithDefaults() {
		let request = SonarrRequest.historyForSeries()

		#expect(request.method == .get)
		#expect(request.path == "api/v3/history/series")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/history/series")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(
			components?.queryItems == [
				URLQueryItem(name: "includeSeries", value: "false"),
				URLQueryItem(name: "includeEpisode", value: "false"),
			]
		)
	}

	@Test func historyForSeriesRequestConstructionWithFilters() {
		let request = SonarrRequest.historyForSeries(
			seriesId: 5,
			seasonNumber: 1,
			eventType: .episodeFileDeleted,
			includeSeries: true,
			includeEpisode: true
		)

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/history/series")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(
			components?.queryItems == [
				URLQueryItem(name: "includeSeries", value: "true"),
				URLQueryItem(name: "includeEpisode", value: "true"),
				URLQueryItem(name: "seriesId", value: "5"),
				URLQueryItem(name: "seasonNumber", value: "1"),
				URLQueryItem(name: "eventType", value: "episodeFileDeleted"),
			]
		)
	}

	@Test func markHistoryEventAsFailedRequestConstruction() {
		let request = SonarrRequest.markHistoryEventAsFailed(id: 42)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/history/failed/42")
	}

	@Test func historyPageDecoding() throws {
		let json = Data(
			#"""
			{
				"page": 1,
				"pageSize": 10,
				"sortKey": "date",
				"sortDirection": "descending",
				"totalRecords": 1,
				"records": [
					{
						"id": 1,
						"episodeId": 10,
						"seriesId": 5,
						"sourceTitle": "Some.Show.S01E01.WEBDL-1080p",
						"languages": [{"id": 1, "name": "English"}],
						"quality": {
							"quality": {"id": 3, "name": "WEBDL-1080p", "source": "web", "resolution": 1080},
							"revision": {"version": 1, "real": 0, "isRepack": false}
						},
						"customFormats": [{"id": 2, "name": "x264"}],
						"customFormatScore": 10,
						"qualityCutoffNotMet": false,
						"date": "2024-01-01T12:00:00Z",
						"downloadId": "abc123",
						"eventType": "grabbed",
						"data": {"indexer": "Some Indexer"}
					}
				]
			}
			"""#.utf8
		)

		let page = try client.decoder.decode(PagingResource<HistoryResource>.self, from: json)

		#expect(page.page == 1)
		#expect(page.totalRecords == 1)
		#expect(page.records.count == 1)

		let entry = try #require(page.records.first)
		#expect(entry.id == 1)
		#expect(entry.episodeId == 10)
		#expect(entry.seriesId == 5)
		#expect(entry.sourceTitle == "Some.Show.S01E01.WEBDL-1080p")
		#expect(entry.languages == [Language(id: 1, name: "English")])
		#expect(entry.quality.quality.name == "WEBDL-1080p")
		#expect(entry.customFormats == [CustomFormat(id: 2, name: "x264")])
		#expect(entry.customFormatScore == 10)
		#expect(entry.qualityCutoffNotMet == false)
		#expect(entry.downloadId == "abc123")
		#expect(entry.eventType == .grabbed)
		#expect(entry.data == ["indexer": "Some Indexer"])
		#expect(entry.episode == nil)
		#expect(entry.series == nil)
	}

	@Test func historyEntryDecodingWithNullableFieldsMissing() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"episodeId": 10,
				"seriesId": 5,
				"quality": {
					"quality": {"id": 3, "name": "WEBDL-1080p", "source": "web", "resolution": 1080},
					"revision": {"version": 1, "real": 0, "isRepack": false}
				},
				"customFormatScore": 0,
				"qualityCutoffNotMet": false,
				"date": "2024-01-01T12:00:00Z",
				"eventType": "unknown"
			}
			"""#.utf8
		)

		let entry = try client.decoder.decode(HistoryResource.self, from: json)

		#expect(entry.sourceTitle == nil)
		#expect(entry.languages == nil)
		#expect(entry.customFormats == nil)
		#expect(entry.downloadId == nil)
		#expect(entry.data == nil)
		#expect(entry.episode == nil)
		#expect(entry.series == nil)
		#expect(entry.eventType == .unknown)
	}

	@Test func historyListDecoding() throws {
		let json = Data(
			#"""
			[
				{
					"id": 1,
					"episodeId": 10,
					"seriesId": 5,
					"quality": {
						"quality": {"id": 3, "name": "WEBDL-1080p", "source": "web", "resolution": 1080},
						"revision": {"version": 1, "real": 0, "isRepack": false}
					},
					"customFormatScore": 0,
					"qualityCutoffNotMet": true,
					"date": "2024-01-01T12:00:00Z",
					"eventType": "downloadFailed"
				}
			]
			"""#.utf8
		)

		let entries = try client.decoder.decode([HistoryResource].self, from: json)

		#expect(entries.count == 1)
		#expect(entries.first?.eventType == .downloadFailed)
		#expect(entries.first?.qualityCutoffNotMet == true)
	}
}
