import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("Release requests")
struct ReleaseRequestsTests {
	let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleRelease: ReleaseResource {
		ReleaseResource(
			guid: "abc123",
			quality: QualityModel(
				quality: Quality(id: 3, name: "WEBDL-1080p", source: "web", resolution: 1080),
				revision: QualityRevision(version: 1, real: 0, isRepack: false)
			),
			indexerId: 1,
			title: "Some.Show.S01E01.WEBDL-1080p",
			protocol: .usenet
		)
	}

	@Test func releasesRequestConstructionWithDefaults() {
		let request = SonarrRequest.releases()

		#expect(request.method == .get)
		#expect(request.path == "api/v3/release")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/release")!)
		let prepared = request.prepare(urlRequest)

		#expect(prepared.url?.absoluteString == "http://localhost:8989/api/v3/release")
	}

	@Test func releasesRequestConstructionWithFilters() {
		let request = SonarrRequest.releases(seriesId: 5, episodeId: 10, seasonNumber: 1)

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/release")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(
			components?.queryItems == [
				URLQueryItem(name: "seriesId", value: "5"),
				URLQueryItem(name: "episodeId", value: "10"),
				URLQueryItem(name: "seasonNumber", value: "1"),
			]
		)
	}

	@Test func grabReleaseRequestConstruction() throws {
		let request = SonarrRequest.grabRelease(sampleRelease)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/release")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(ReleaseResource.self, from: try body.encode())
		#expect(decoded == sampleRelease)
	}

	@Test func releaseResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"guid": "abc123",
				"quality": {
					"quality": {"id": 3, "name": "WEBDL-1080p", "source": "web", "resolution": 1080},
					"revision": {"version": 1, "real": 0, "isRepack": false}
				},
				"age": 2,
				"ageHours": 48.0,
				"ageMinutes": 2880.0,
				"size": 123456789,
				"indexerId": 1,
				"indexer": "Some Indexer",
				"title": "Some.Show.S01E01.WEBDL-1080p",
				"fullSeason": false,
				"sceneSource": false,
				"seasonNumber": 1,
				"languages": [{"id": 1, "name": "English"}],
				"episodeNumbers": [1],
				"approved": true,
				"temporarilyRejected": false,
				"rejected": false,
				"tvdbId": 100,
				"tvRageId": 0,
				"rejections": [],
				"publishDate": "2024-01-01T12:00:00Z",
				"downloadUrl": "http://example.com/download",
				"episodeRequested": false,
				"downloadAllowed": true,
				"releaseWeight": 0,
				"customFormats": [],
				"customFormatScore": 0,
				"protocol": "usenet",
				"indexerFlags": 0,
				"isDaily": false,
				"isAbsoluteNumbering": false,
				"isPossibleSpecialEpisode": false,
				"special": false,
				"seriesId": 5,
				"episodeId": 10,
				"episodeIds": [10]
			}
			"""#.utf8
		)

		let release = try client.decoder.decode(ReleaseResource.self, from: json)

		#expect(release.id == 1)
		#expect(release.guid == "abc123")
		#expect(release.quality?.quality.name == "WEBDL-1080p")
		#expect(release.age == 2)
		#expect(release.size == 123_456_789)
		#expect(release.indexer == "Some Indexer")
		#expect(release.title == "Some.Show.S01E01.WEBDL-1080p")
		#expect(release.languages == [Language(id: 1, name: "English")])
		#expect(release.episodeNumbers == [1])
		#expect(release.approved == true)
		#expect(release.rejected == false)
		#expect(release.tvdbId == 100)
		#expect(release.downloadUrl == "http://example.com/download")
		#expect(release.protocol == .usenet)
		#expect(release.seriesId == 5)
		#expect(release.episodeId == 10)
		#expect(release.episodeIds == [10])
		#expect(release.mappedEpisodeInfo == nil)
		#expect(release.sceneMapping == nil)
	}

	@Test func releaseResourceDecodingWithNullableFieldsMissing() throws {
		let json = Data(
			#"""
			{
				"id": 2
			}
			"""#.utf8
		)

		let release = try client.decoder.decode(ReleaseResource.self, from: json)

		#expect(release.id == 2)
		#expect(release.guid == nil)
		#expect(release.quality == nil)
		#expect(release.languages == nil)
		#expect(release.customFormats == nil)
		#expect(release.protocol == nil)
		#expect(release.mappedEpisodeInfo == nil)
		#expect(release.sceneMapping == nil)
	}

	@Test func releaseListDecoding() throws {
		let json = Data(
			#"""
			[
				{
					"id": 1,
					"guid": "abc123"
				}
			]
			"""#.utf8
		)

		let releases = try client.decoder.decode([ReleaseResource].self, from: json)

		#expect(releases.count == 1)
		#expect(releases.first?.guid == "abc123")
	}
}
