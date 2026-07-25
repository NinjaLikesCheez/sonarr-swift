import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("RenameEpisode requests")
struct RenameEpisodeRequestsTests {
	let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	@Test func renamesRequestConstructionWithDefaults() {
		let request = SonarrRequest.renames()

		#expect(request.method == .get)
		#expect(request.path == "api/v3/rename")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/rename")!)
		let prepared = request.prepare(urlRequest)

		#expect(prepared.url?.absoluteString == "http://localhost:8989/api/v3/rename")
	}

	@Test func renamesRequestConstructionWithFilters() {
		let request = SonarrRequest.renames(seriesId: 5, seasonNumber: 1)

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/rename")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(
			components?.queryItems == [
				URLQueryItem(name: "seriesId", value: "5"),
				URLQueryItem(name: "seasonNumber", value: "1"),
			]
		)
	}

	@Test func renameEpisodeResourceDecoding() throws {
		let json = Data(
			#"""
			[
				{
					"id": 1,
					"seriesId": 5,
					"seasonNumber": 1,
					"episodeNumbers": [1, 2],
					"episodeFileId": 10,
					"existingPath": "Some Show/Season 01/S01E01E02.mkv",
					"newPath": "Some Show/Season 01/Some Show - S01E01-E02 - Title.mkv"
				}
			]
			"""#.utf8
		)

		let renames = try client.decoder.decode([RenameEpisodeResource].self, from: json)

		#expect(renames.count == 1)

		let rename = try #require(renames.first)
		#expect(rename.id == 1)
		#expect(rename.seriesId == 5)
		#expect(rename.seasonNumber == 1)
		#expect(rename.episodeNumbers == [1, 2])
		#expect(rename.episodeFileId == 10)
		#expect(rename.existingPath == "Some Show/Season 01/S01E01E02.mkv")
		#expect(rename.newPath == "Some Show/Season 01/Some Show - S01E01-E02 - Title.mkv")
	}

	@Test func renameEpisodeResourceDecodingWithNullableFieldsMissing() throws {
		let json = Data(
			#"""
			{
				"id": 2
			}
			"""#.utf8
		)

		let rename = try client.decoder.decode(RenameEpisodeResource.self, from: json)

		#expect(rename.id == 2)
		#expect(rename.seriesId == nil)
		#expect(rename.episodeNumbers == nil)
		#expect(rename.existingPath == nil)
		#expect(rename.newPath == nil)
	}
}
