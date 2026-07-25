import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("Queue requests")
struct QueueRequestsTests {
	let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	@Test func queueRequestConstructionWithDefaults() {
		let request = SonarrRequest.queue()

		#expect(request.method == .get)
		#expect(request.path == "api/v3/queue")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/queue")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(
			components?.queryItems == [
				URLQueryItem(name: "includeUnknownSeriesItems", value: "false"),
				URLQueryItem(name: "includeSeries", value: "false"),
				URLQueryItem(name: "includeEpisode", value: "false"),
			]
		)
	}

	@Test func queueRequestConstructionWithFilters() {
		let request = SonarrRequest.queue(
			page: 2,
			pageSize: 25,
			sortKey: "timeleft",
			sortDirection: "descending",
			includeUnknownSeriesItems: true,
			includeSeries: true,
			includeEpisode: true,
			seriesIds: [1, 2],
			protocol: .usenet,
			languages: [1],
			quality: [3],
			status: [.downloading, .completed]
		)

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/queue")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(
			components?.queryItems == [
				URLQueryItem(name: "includeUnknownSeriesItems", value: "true"),
				URLQueryItem(name: "includeSeries", value: "true"),
				URLQueryItem(name: "includeEpisode", value: "true"),
				URLQueryItem(name: "page", value: "2"),
				URLQueryItem(name: "pageSize", value: "25"),
				URLQueryItem(name: "sortKey", value: "timeleft"),
				URLQueryItem(name: "sortDirection", value: "descending"),
				URLQueryItem(name: "protocol", value: "usenet"),
				URLQueryItem(name: "seriesIds", value: "1"),
				URLQueryItem(name: "seriesIds", value: "2"),
				URLQueryItem(name: "languages", value: "1"),
				URLQueryItem(name: "quality", value: "3"),
				URLQueryItem(name: "status", value: "downloading"),
				URLQueryItem(name: "status", value: "completed"),
			]
		)
	}

	@Test func deleteQueueItemRequestConstructionWithDefaults() {
		let request = SonarrRequest.deleteQueueItem(id: 42)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/queue/42")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/queue/42")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(
			components?.queryItems == [
				URLQueryItem(name: "removeFromClient", value: "true"),
				URLQueryItem(name: "blocklist", value: "false"),
				URLQueryItem(name: "skipRedownload", value: "false"),
				URLQueryItem(name: "changeCategory", value: "false"),
			]
		)
	}

	@Test func deleteQueueItemRequestConstructionWithOverrides() {
		let request = SonarrRequest.deleteQueueItem(
			id: 42,
			removeFromClient: false,
			blocklist: true,
			skipRedownload: true,
			changeCategory: true
		)

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/queue/42")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(
			components?.queryItems == [
				URLQueryItem(name: "removeFromClient", value: "false"),
				URLQueryItem(name: "blocklist", value: "true"),
				URLQueryItem(name: "skipRedownload", value: "true"),
				URLQueryItem(name: "changeCategory", value: "true"),
			]
		)
	}

	@Test func deleteQueueItemsRequestConstruction() throws {
		let request = SonarrRequest.deleteQueueItems(ids: [1, 2, 3], blocklist: true)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/queue/bulk")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/queue/bulk")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(
			components?.queryItems == [
				URLQueryItem(name: "removeFromClient", value: "true"),
				URLQueryItem(name: "blocklist", value: "true"),
				URLQueryItem(name: "skipRedownload", value: "false"),
				URLQueryItem(name: "changeCategory", value: "false"),
			]
		)

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: [Int]])

		#expect(json["ids"] == [1, 2, 3])
	}

	@Test func queuePageDecoding() throws {
		let json = Data(
			#"""
			{
				"page": 1,
				"pageSize": 10,
				"sortKey": "timeleft",
				"sortDirection": "ascending",
				"totalRecords": 1,
				"records": [
					{
						"id": 1,
						"seriesId": 5,
						"episodeId": 10,
						"seasonNumber": 1,
						"languages": [{"id": 1, "name": "English"}],
						"quality": {
							"quality": {"id": 3, "name": "WEBDL-1080p", "source": "web", "resolution": 1080},
							"revision": {"version": 1, "real": 0, "isRepack": false}
						},
						"customFormats": [{"id": 2, "name": "x264"}],
						"customFormatScore": 10,
						"size": 1234.5,
						"title": "Some.Show.S01E01.WEBDL-1080p",
						"added": "2024-01-01T12:00:00Z",
						"status": "downloading",
						"trackedDownloadStatus": "ok",
						"trackedDownloadState": "downloading",
						"statusMessages": [{"title": "Some.Show.S01E01.WEBDL-1080p", "messages": ["Sample"]}],
						"downloadId": "abc123",
						"protocol": "usenet",
						"downloadClient": "SABnzbd",
						"downloadClientHasPostImportCategory": true,
						"indexer": "Some Indexer",
						"outputPath": "/downloads/Some.Show.S01E01.WEBDL-1080p",
						"episodeHasFile": false
					}
				]
			}
			"""#.utf8
		)

		let page = try client.decoder.decode(PagingResource<QueueResource>.self, from: json)

		#expect(page.page == 1)
		#expect(page.totalRecords == 1)
		#expect(page.records.count == 1)

		let item = try #require(page.records.first)
		#expect(item.id == 1)
		#expect(item.seriesId == 5)
		#expect(item.episodeId == 10)
		#expect(item.seasonNumber == 1)
		#expect(item.languages == [Language(id: 1, name: "English")])
		#expect(item.quality?.quality.name == "WEBDL-1080p")
		#expect(item.customFormats == [CustomFormat(id: 2, name: "x264")])
		#expect(item.customFormatScore == 10)
		#expect(item.size == 1234.5)
		#expect(item.title == "Some.Show.S01E01.WEBDL-1080p")
		#expect(item.status == .downloading)
		#expect(item.trackedDownloadStatus == .ok)
		#expect(item.trackedDownloadState == .downloading)
		#expect(
			item.statusMessages == [TrackedDownloadStatusMessage(title: "Some.Show.S01E01.WEBDL-1080p", messages: ["Sample"])]
		)
		#expect(item.downloadId == "abc123")
		#expect(item.protocol == .usenet)
		#expect(item.downloadClient == "SABnzbd")
		#expect(item.downloadClientHasPostImportCategory == true)
		#expect(item.indexer == "Some Indexer")
		#expect(item.outputPath == "/downloads/Some.Show.S01E01.WEBDL-1080p")
		#expect(item.episodeHasFile == false)
		#expect(item.series == nil)
		#expect(item.episode == nil)
	}

	@Test func queueItemDecodingWithNullableFieldsMissing() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"customFormatScore": 0,
				"size": 0,
				"downloadClientHasPostImportCategory": false,
				"episodeHasFile": false
			}
			"""#.utf8
		)

		let item = try client.decoder.decode(QueueResource.self, from: json)

		#expect(item.id == 1)
		#expect(item.seriesId == nil)
		#expect(item.episodeId == nil)
		#expect(item.seasonNumber == nil)
		#expect(item.series == nil)
		#expect(item.episode == nil)
		#expect(item.languages == nil)
		#expect(item.quality == nil)
		#expect(item.customFormats == nil)
		#expect(item.title == nil)
		#expect(item.estimatedCompletionTime == nil)
		#expect(item.added == nil)
		#expect(item.status == nil)
		#expect(item.trackedDownloadStatus == nil)
		#expect(item.trackedDownloadState == nil)
		#expect(item.statusMessages == nil)
		#expect(item.errorMessage == nil)
		#expect(item.downloadId == nil)
		#expect(item.protocol == nil)
		#expect(item.downloadClient == nil)
		#expect(item.indexer == nil)
		#expect(item.outputPath == nil)
	}
}
