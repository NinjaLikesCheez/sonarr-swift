import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("Parse requests")
struct ParseRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	@Test func parseRequestConstructionWithNoFilters() {
		let request = SonarrRequest.parse()

		#expect(request.method == .get)
		#expect(request.path == "api/v3/parse")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/parse")!)
		let prepared = request.prepare(urlRequest)

		#expect(prepared.url?.absoluteString == "http://localhost:8989/api/v3/parse")
	}

	@Test func parseRequestConstructionWithTitle() {
		let request = SonarrRequest.parse(title: "Some.Show.S01E02.1080p.WEB.h264-GROUP")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/parse")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(
			components?.queryItems == [
				URLQueryItem(name: "title", value: "Some.Show.S01E02.1080p.WEB.h264-GROUP")
			]
		)
	}

	@Test func parseRequestConstructionWithPath() {
		let request = SonarrRequest.parse(path: "/downloads/Some.Show.S01E02.1080p.WEB.h264-GROUP.mkv")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/parse")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(
			components?.queryItems == [
				URLQueryItem(name: "path", value: "/downloads/Some.Show.S01E02.1080p.WEB.h264-GROUP.mkv")
			]
		)
	}

	@Test func parseResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"title": "Some.Show.S01E02.1080p.WEB.h264-GROUP",
				"parsedEpisodeInfo": {
					"releaseTitle": "Some.Show.S01E02.1080p.WEB.h264-GROUP",
					"seriesTitle": "Some Show",
					"seriesTitleInfo": {
						"title": "Some Show",
						"titleWithoutYear": "Some Show",
						"year": 0
					},
					"quality": {
						"quality": {
							"id": 3,
							"name": "WEBDL-1080p",
							"source": "web",
							"resolution": 1080
						},
						"revision": {
							"version": 1,
							"real": 0,
							"isRepack": false
						}
					},
					"seasonNumber": 1,
					"episodeNumbers": [2],
					"absoluteEpisodeNumbers": [],
					"specialAbsoluteEpisodeNumbers": [],
					"languages": [
						{ "id": 0, "name": "Unknown" }
					],
					"fullSeason": false,
					"isPartialSeason": false,
					"isMultiSeason": false,
					"isSeasonExtra": false,
					"isSplitEpisode": false,
					"isMiniSeries": false,
					"special": false,
					"releaseGroup": "GROUP",
					"releaseHash": "",
					"seasonPart": 0,
					"releaseTokens": ".1080p.WEB.h264-GROUP",
					"isDaily": false,
					"isAbsoluteNumbering": false,
					"isPossibleSpecialEpisode": false,
					"isPossibleSceneSeasonSpecial": false,
					"releaseType": "singleEpisode"
				},
				"episodes": [],
				"languages": [
					{ "id": 0, "name": "Unknown" }
				],
				"customFormats": [],
				"customFormatScore": 0
			}
			"""#.utf8
		)

		let parsed = try client.decoder.decode(ParseResource.self, from: json)

		#expect(parsed.id == nil)
		#expect(parsed.title == "Some.Show.S01E02.1080p.WEB.h264-GROUP")
		#expect(parsed.parsedEpisodeInfo?.seriesTitle == "Some Show")
		#expect(parsed.parsedEpisodeInfo?.seriesTitleInfo?.title == "Some Show")
		#expect(parsed.parsedEpisodeInfo?.seasonNumber == 1)
		#expect(parsed.parsedEpisodeInfo?.episodeNumbers == [2])
		#expect(parsed.parsedEpisodeInfo?.releaseGroup == "GROUP")
		#expect(parsed.parsedEpisodeInfo?.releaseType == .singleEpisode)
		#expect(parsed.series == nil)
		#expect(parsed.episodes == [])
		#expect(parsed.customFormatScore == 0)
	}

	@Test func parseResourceDecodingWithNullableFields() throws {
		let json = Data(
			#"""
			{
				"title": null,
				"parsedEpisodeInfo": null,
				"episodes": null,
				"languages": null,
				"customFormats": null
			}
			"""#.utf8
		)

		let parsed = try client.decoder.decode(ParseResource.self, from: json)

		#expect(parsed.title == nil)
		#expect(parsed.parsedEpisodeInfo == nil)
		#expect(parsed.episodes == nil)
		#expect(parsed.customFormats == nil)
	}
}
