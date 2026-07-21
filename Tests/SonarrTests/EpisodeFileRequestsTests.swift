import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("EpisodeFile requests")
struct EpisodeFileRequestsTests {
	let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleEpisodeFile: EpisodeFileResource {
		EpisodeFileResource(
			id: 1,
			seriesId: 5,
			seasonNumber: 1,
			relativePath: "Season 01/Some.Show.S01E01.mkv",
			path: "/tv/Some Show/Season 01/Some.Show.S01E01.mkv",
			size: 123_456,
			dateAdded: Date(timeIntervalSince1970: 1_704_110_400),
			sceneName: "Some.Show.S01E01.WEBDL-1080p",
			releaseGroup: "GROUP",
			languages: [Language(id: 1, name: "English")],
			quality: QualityModel(
				quality: Quality(id: 3, name: "WEBDL-1080p", source: "web", resolution: 1080),
				revision: QualityRevision(version: 1, real: 0, isRepack: false)
			),
			customFormats: nil,
			customFormatScore: 0,
			indexerFlags: 0,
			releaseType: .singleEpisode,
			mediaInfo: nil,
			qualityCutoffNotMet: false
		)
	}

	@Test func episodeFilesRequestConstructionWithDefaults() {
		let request = SonarrRequest.episodeFiles()

		#expect(request.method == .get)
		#expect(request.path == "api/v3/episodefile")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/episodefile")!)
		let prepared = request.prepare(urlRequest)

		#expect(prepared.url?.absoluteString == "http://localhost:8989/api/v3/episodefile")
	}

	@Test func episodeFilesRequestConstructionWithFilters() {
		let request = SonarrRequest.episodeFiles(seriesId: 5, episodeFileIds: [1, 2])

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/episodefile")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(
			components?.queryItems == [
				URLQueryItem(name: "seriesId", value: "5"),
				URLQueryItem(name: "episodeFileIds", value: "1"),
				URLQueryItem(name: "episodeFileIds", value: "2"),
			]
		)
	}

	@Test func episodeFileRequestConstruction() {
		let request = SonarrRequest.episodeFile(id: 42)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/episodefile/42")
	}

	@Test func updateEpisodeFileRequestConstruction() throws {
		let request = SonarrRequest.updateEpisodeFile(id: 1, sampleEpisodeFile)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/episodefile/1")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(EpisodeFileResource.self, from: try body.encode())
		#expect(decoded == sampleEpisodeFile)
	}

	@Test func deleteEpisodeFileRequestConstruction() {
		let request = SonarrRequest.deleteEpisodeFile(id: 42)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/episodefile/42")
	}

	@Test func editEpisodeFilesRequestConstruction() throws {
		let edit = EpisodeFileListResource(episodeFileIds: [1, 2, 3], releaseGroup: "GROUP")
		let request = SonarrRequest.editEpisodeFiles(edit)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/episodefile/editor")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(EpisodeFileListResourceFixture.self, from: try body.encode())
		#expect(decoded.episodeFileIds == [1, 2, 3])
		#expect(decoded.releaseGroup == "GROUP")
	}

	@Test func deleteEpisodeFilesRequestConstruction() throws {
		let delete = EpisodeFileListResource(episodeFileIds: [1, 2, 3])
		let request = SonarrRequest.deleteEpisodeFiles(delete)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/episodefile/bulk")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(EpisodeFileListResourceFixture.self, from: try body.encode())
		#expect(decoded.episodeFileIds == [1, 2, 3])
	}

	@Test func updateEpisodeFilesRequestConstruction() throws {
		let request = SonarrRequest.updateEpisodeFiles([sampleEpisodeFile])

		#expect(request.method == .put)
		#expect(request.path == "api/v3/episodefile/bulk")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode([EpisodeFileResource].self, from: try body.encode())
		#expect(decoded == [sampleEpisodeFile])
	}

	@Test func episodeFileDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"seriesId": 5,
				"seasonNumber": 1,
				"relativePath": "Season 01/Some.Show.S01E01.mkv",
				"path": "/tv/Some Show/Season 01/Some.Show.S01E01.mkv",
				"size": 123456,
				"dateAdded": "2024-01-01T12:00:00Z",
				"sceneName": "Some.Show.S01E01.WEBDL-1080p",
				"releaseGroup": "GROUP",
				"languages": [{"id": 1, "name": "English"}],
				"quality": {
					"quality": {"id": 3, "name": "WEBDL-1080p", "source": "web", "resolution": 1080},
					"revision": {"version": 1, "real": 0, "isRepack": false}
				},
				"customFormats": [{"id": 2, "name": "x264", "includeCustomFormatWhenRenaming": false, "specifications": []}],
				"customFormatScore": 10,
				"indexerFlags": 0,
				"releaseType": "singleEpisode",
				"mediaInfo": {
					"id": 1,
					"audioBitrate": 128000,
					"audioChannels": 2,
					"audioCodec": "AAC",
					"audioLanguages": "eng",
					"audioStreamCount": 1,
					"videoBitDepth": 8,
					"videoBitrate": 4000000,
					"videoCodec": "x264",
					"videoFps": 23.976,
					"videoDynamicRange": null,
					"videoDynamicRangeType": null,
					"resolution": "1920x1080",
					"runTime": "45:00",
					"scanType": "Progressive",
					"subtitles": "eng"
				},
				"qualityCutoffNotMet": false
			}
			"""#.utf8
		)

		let episodeFile = try client.decoder.decode(EpisodeFileResource.self, from: json)

		#expect(episodeFile.id == 1)
		#expect(episodeFile.seriesId == 5)
		#expect(episodeFile.sceneName == "Some.Show.S01E01.WEBDL-1080p")
		#expect(episodeFile.releaseGroup == "GROUP")
		#expect(episodeFile.customFormats?.first?.name == "x264")
		#expect(episodeFile.customFormatScore == 10)
		#expect(episodeFile.releaseType == .singleEpisode)
		#expect(episodeFile.mediaInfo?.audioCodec == "AAC")
		#expect(episodeFile.mediaInfo?.videoFps == 23.976)
		#expect(episodeFile.qualityCutoffNotMet == false)
	}

	@Test func episodeFileListDecoding() throws {
		let json = Data(
			#"""
			[
				{
					"id": 1,
					"seriesId": 5,
					"seasonNumber": 1,
					"size": 123456,
					"dateAdded": "2024-01-01T12:00:00Z",
					"quality": {
						"quality": {"id": 3, "name": "WEBDL-1080p", "source": "web", "resolution": 1080},
						"revision": {"version": 1, "real": 0, "isRepack": false}
					},
					"customFormatScore": 0,
					"releaseType": "seasonPack",
					"qualityCutoffNotMet": true
				}
			]
			"""#.utf8
		)

		let episodeFiles = try client.decoder.decode([EpisodeFileResource].self, from: json)

		#expect(episodeFiles.count == 1)
		#expect(episodeFiles.first?.releaseType == .seasonPack)
		#expect(episodeFiles.first?.qualityCutoffNotMet == true)
	}
}

private struct EpisodeFileListResourceFixture: Decodable {
	let episodeFileIds: [Int]?
	let languages: [Language]?
	let sceneName: String?
	let releaseGroup: String?
}
