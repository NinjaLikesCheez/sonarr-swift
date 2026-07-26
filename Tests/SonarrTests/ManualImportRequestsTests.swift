import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("ManualImport requests")
struct ManualImportRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	@Test func manualImportRequestConstructionWithDefaults() {
		let request = SonarrRequest.manualImport()

		#expect(request.method == .get)
		#expect(request.path == "api/v3/manualimport")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/manualimport")!)
		let prepared = request.prepare(urlRequest)

		#expect(prepared.url?.absoluteString == "http://localhost:8989/api/v3/manualimport")
	}

	@Test func manualImportRequestConstructionWithFilters() {
		let request = SonarrRequest.manualImport(
			folder: "/downloads/show",
			downloadId: "abc123",
			seriesId: 1,
			seasonNumber: 2,
			filterExistingFiles: false
		)

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/manualimport")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(
			components?.queryItems == [
				URLQueryItem(name: "folder", value: "/downloads/show"),
				URLQueryItem(name: "downloadId", value: "abc123"),
				URLQueryItem(name: "seriesId", value: "1"),
				URLQueryItem(name: "seasonNumber", value: "2"),
				URLQueryItem(name: "filterExistingFiles", value: "false"),
			]
		)
	}

	@Test func manualImportReprocessRequestConstruction() throws {
		let reprocessed = [
			ManualImportReprocessResource(id: 1, path: "/downloads/show/episode.mkv", seriesId: 42, episodeIds: [7])
		]

		let request = SonarrRequest.manualImport(reprocessed)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/manualimport")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [[String: Any]])

		#expect(json.count == 1)

		let first = try #require(json.first)
		#expect(first["id"] as? Int == 1)
		#expect(first["path"] as? String == "/downloads/show/episode.mkv")
		#expect(first["seriesId"] as? Int == 42)
		#expect(first["episodeIds"] as? [Int] == [7])
	}

	@Test func manualImportResourceListDecoding() throws {
		let json = Data(
			#"""
			[
				{
					"id": 1,
					"path": "/downloads/show/episode.mkv",
					"relativePath": "episode.mkv",
					"folderName": "show",
					"name": "episode.mkv",
					"size": 123456789,
					"seasonNumber": 1,
					"episodeFileId": null,
					"releaseGroup": "GROUP",
					"languages": [
						{ "id": 1, "name": "English" }
					],
					"qualityWeight": 100,
					"downloadId": "abc123",
					"customFormatScore": 0,
					"indexerFlags": 0,
					"releaseType": "singleEpisode",
					"rejections": [
						{ "reason": "Episode file already exists", "type": "permanent" }
					]
				}
			]
			"""#.utf8
		)

		let candidates = try client.decoder.decode([ManualImportResource].self, from: json)

		#expect(candidates.count == 1)

		let candidate = try #require(candidates.first)
		#expect(candidate.id == 1)
		#expect(candidate.path == "/downloads/show/episode.mkv")
		#expect(candidate.size == 123_456_789)
		#expect(candidate.seasonNumber == 1)
		#expect(candidate.releaseGroup == "GROUP")
		#expect(candidate.languages == [Language(id: 1, name: "English")])
		#expect(candidate.releaseType == .singleEpisode)
		#expect(candidate.rejections?.count == 1)
		#expect(candidate.rejections?.first?.type == .permanent)
	}

	@Test func manualImportResourceDecodingWithNullableFields() throws {
		let json = Data(
			#"""
			{
				"id": 2,
				"path": null,
				"relativePath": null,
				"folderName": null,
				"name": null,
				"seasonNumber": null,
				"episodes": null,
				"episodeFileId": null,
				"releaseGroup": null,
				"languages": null,
				"downloadId": null,
				"customFormats": null,
				"rejections": null
			}
			"""#.utf8
		)

		let candidate = try client.decoder.decode(ManualImportResource.self, from: json)

		#expect(candidate.id == 2)
		#expect(candidate.path == nil)
		#expect(candidate.series == nil)
		#expect(candidate.episodes == nil)
		#expect(candidate.rejections == nil)
	}
}
