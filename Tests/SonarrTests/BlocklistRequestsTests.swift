import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("Blocklist requests")
struct BlocklistRequestsTests {
	@Test func blocklistRequestConstructionWithNoFilters() {
		let request = SonarrRequest.blocklist()

		#expect(request.method == .get)
		#expect(request.path == "api/v3/blocklist")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/blocklist")!)
		let prepared = request.prepare(urlRequest)

		#expect(prepared.url?.absoluteString == "http://localhost:8989/api/v3/blocklist")
	}

	@Test func blocklistRequestConstructionWithFilters() {
		let request = SonarrRequest.blocklist(
			page: 2,
			pageSize: 25,
			sortKey: "date",
			sortDirection: "descending",
			seriesIds: [1, 2],
			protocols: [.usenet, .torrent]
		)

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/blocklist")!)
		let prepared = request.prepare(urlRequest)

		#expect(
			prepared.url?.absoluteString
				== "http://localhost:8989/api/v3/blocklist?page=2&pageSize=25&sortKey=date&sortDirection=descending&seriesIds=1&seriesIds=2&protocols=usenet&protocols=torrent"
		)
	}

	@Test func deleteBlocklistEntryRequestConstruction() {
		let request = SonarrRequest.deleteBlocklistEntry(id: 42)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/blocklist/42")
	}

	@Test func deleteBlocklistEntriesRequestConstruction() throws {
		let request = SonarrRequest.deleteBlocklistEntries(ids: [1, 2, 3])

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/blocklist/bulk")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: [Int]])

		#expect(json["ids"] == [1, 2, 3])
	}

	@Test func blocklistPageDecoding() throws {
		let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")
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
						"seriesId": 5,
						"episodeIds": [10, 11],
						"sourceTitle": "Some.Show.S01E01.WEBDL-1080p",
						"languages": [{"id": 1, "name": "English"}],
						"quality": {
							"quality": {"id": 3, "name": "WEBDL-1080p", "source": "web", "resolution": 1080},
							"revision": {"version": 1, "real": 0, "isRepack": false}
						},
						"customFormats": [{"id": 2, "name": "x264"}],
						"date": "2024-01-01T12:00:00Z",
						"protocol": "usenet",
						"indexer": "Some Indexer",
						"message": "Marked as failed"
					}
				]
			}
			"""#.utf8
		)

		let page = try client.decoder.decode(PagingResource<Blocklist>.self, from: json)

		#expect(page.page == 1)
		#expect(page.totalRecords == 1)
		#expect(page.records.count == 1)

		let entry = try #require(page.records.first)
		#expect(entry.id == 1)
		#expect(entry.seriesId == 5)
		#expect(entry.episodeIds == [10, 11])
		#expect(entry.sourceTitle == "Some.Show.S01E01.WEBDL-1080p")
		#expect(entry.languages == [Language(id: 1, name: "English")])
		#expect(entry.quality.quality.name == "WEBDL-1080p")
		#expect(entry.quality.revision.version == 1)
		#expect(entry.customFormats == [CustomFormat(id: 2, name: "x264")])
		#expect(entry.protocol == .usenet)
		#expect(entry.indexer == "Some Indexer")
		#expect(entry.message == "Marked as failed")
	}

	@Test func blocklistEntryDecodingWithNullableFieldsMissing() throws {
		let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")
		let json = Data(
			#"""
			{
				"id": 1,
				"seriesId": 5,
				"episodeIds": [10],
				"sourceTitle": "Some.Show.S01E01.WEBDL-1080p",
				"languages": [],
				"quality": {
					"quality": {"id": 3, "name": "WEBDL-1080p", "source": "web", "resolution": 1080},
					"revision": {"version": 1, "real": 0, "isRepack": false}
				},
				"date": "2024-01-01T12:00:00Z",
				"protocol": "torrent"
			}
			"""#.utf8
		)

		let entry = try client.decoder.decode(Blocklist.self, from: json)

		#expect(entry.customFormats == nil)
		#expect(entry.indexer == nil)
		#expect(entry.message == nil)
		#expect(entry.protocol == .torrent)
	}
}
