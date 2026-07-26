import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("Series requests")
struct SeriesRequestsTests {
	let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleSeries: SeriesResource {
		SeriesResource(
			id: 1,
			title: "Some Show",
			status: .continuing,
			year: 2020,
			path: "/media/Some Show",
			qualityProfileId: 1,
			seasonFolder: true,
			monitored: true,
			monitorNewItems: .all,
			useSceneNumbering: false,
			runtime: 30,
			tvdbId: 12345,
			tvRageId: 0,
			tvMazeId: 0,
			tmdbId: 0,
			seriesType: .standard,
			tags: []
		)
	}

	@Test func seriesListRequestConstructionWithDefaults() {
		let request = SonarrRequest.series()

		#expect(request.method == .get)
		#expect(request.path == "api/v3/series")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/series")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(components?.queryItems == [URLQueryItem(name: "includeSeasonImages", value: "false")])
	}

	@Test func seriesListRequestConstructionWithFilters() {
		let request = SonarrRequest.series(tvdbId: 12345, includeSeasonImages: true)

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/series")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(
			components?.queryItems == [
				URLQueryItem(name: "includeSeasonImages", value: "true"),
				URLQueryItem(name: "tvdbId", value: "12345"),
			]
		)
	}

	@Test func importSeriesRequestConstruction() throws {
		let request = SonarrRequest.importSeries([sampleSeries])

		#expect(request.method == .post)
		#expect(request.path == "api/v3/series/import")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode([SeriesResource].self, from: try body.encode())
		#expect(decoded == [sampleSeries])
	}

	@Test func lookupSeriesRequestConstructionWithDefaults() {
		let request = SonarrRequest.lookupSeries()

		#expect(request.method == .get)
		#expect(request.path == "api/v3/series/lookup")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/series/lookup")!)
		let prepared = request.prepare(urlRequest)

		#expect(prepared.url?.absoluteString == "http://localhost:8989/api/v3/series/lookup")
	}

	@Test func lookupSeriesRequestConstructionWithTerm() {
		let request = SonarrRequest.lookupSeries(term: "The Simpsons")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/series/lookup")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(components?.queryItems == [URLQueryItem(name: "term", value: "The Simpsons")])
	}

	@Test func seriesByIdRequestConstructionWithDefaults() {
		let request = SonarrRequest.series(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/series/1")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/series/1")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(components?.queryItems == [URLQueryItem(name: "includeSeasonImages", value: "false")])
	}

	@Test func seriesByIdRequestConstructionWithIncludeSeasonImages() {
		let request = SonarrRequest.series(id: 1, includeSeasonImages: true)

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/series/1")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(components?.queryItems == [URLQueryItem(name: "includeSeasonImages", value: "true")])
	}

	@Test func addSeriesRequestConstruction() throws {
		let request = SonarrRequest.addSeries(sampleSeries)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/series")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(SeriesResource.self, from: try body.encode())
		#expect(decoded == sampleSeries)
	}

	@Test func updateSeriesRequestConstructionWithDefaults() throws {
		let request = SonarrRequest.updateSeries(id: 1, sampleSeries)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/series/1")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/series/1")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == [URLQueryItem(name: "moveFiles", value: "false")])

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(SeriesResource.self, from: try body.encode())
		#expect(decoded == sampleSeries)
	}

	@Test func updateSeriesRequestConstructionWithMoveFiles() {
		let request = SonarrRequest.updateSeries(id: 1, sampleSeries, moveFiles: true)

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/series/1")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == [URLQueryItem(name: "moveFiles", value: "true")])
	}

	@Test func deleteSeriesRequestConstructionWithDefaults() {
		let request = SonarrRequest.deleteSeries(id: 1)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/series/1")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/series/1")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(
			components?.queryItems == [
				URLQueryItem(name: "deleteFiles", value: "false"),
				URLQueryItem(name: "addImportListExclusion", value: "false"),
			]
		)
	}

	@Test func deleteSeriesRequestConstructionWithOverrides() {
		let request = SonarrRequest.deleteSeries(id: 1, deleteFiles: true, addImportListExclusion: true)

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/series/1")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(
			components?.queryItems == [
				URLQueryItem(name: "deleteFiles", value: "true"),
				URLQueryItem(name: "addImportListExclusion", value: "true"),
			]
		)
	}

	@Test func seriesResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"title": "Some Show",
				"alternateTitles": [{"title": "Alt Title"}],
				"sortTitle": "some show",
				"status": "continuing",
				"ended": false,
				"overview": "A show about something.",
				"network": "Some Network",
				"images": [{"coverType": "poster", "url": "/poster.jpg"}],
				"originalLanguage": {"id": 1, "name": "English"},
				"seasons": [{"seasonNumber": 1, "monitored": true}],
				"year": 2020,
				"path": "/media/Some Show",
				"qualityProfileId": 1,
				"seasonFolder": true,
				"monitored": true,
				"monitorNewItems": "all",
				"useSceneNumbering": false,
				"runtime": 30,
				"tvdbId": 12345,
				"tvRageId": 0,
				"tvMazeId": 0,
				"tmdbId": 0,
				"seriesType": "standard",
				"cleanTitle": "someshow",
				"titleSlug": "some-show",
				"genres": ["Drama"],
				"tags": [1, 2],
				"added": "2024-01-01T12:00:00Z",
				"ratings": {"votes": 100, "value": 8.5},
				"statistics": {
					"seasonCount": 1,
					"episodeFileCount": 10,
					"episodeCount": 10,
					"totalEpisodeCount": 10,
					"sizeOnDisk": 123456789,
					"releaseGroups": ["GROUP"],
					"percentOfEpisodes": 100.0
				}
			}
			"""#.utf8
		)

		let series = try client.decoder.decode(SeriesResource.self, from: json)

		#expect(series.id == 1)
		#expect(series.title == "Some Show")
		#expect(series.alternateTitles?.first?.title == "Alt Title")
		#expect(series.status == .continuing)
		#expect(series.ended == false)
		#expect(series.network == "Some Network")
		#expect(series.images?.first?.coverType == .poster)
		#expect(series.originalLanguage == Language(id: 1, name: "English"))
		#expect(series.seasons?.first?.seasonNumber == 1)
		#expect(series.year == 2020)
		#expect(series.path == "/media/Some Show")
		#expect(series.qualityProfileId == 1)
		#expect(series.monitored == true)
		#expect(series.monitorNewItems == .all)
		#expect(series.tvdbId == 12345)
		#expect(series.seriesType == .standard)
		#expect(series.genres == ["Drama"])
		#expect(series.tags == [1, 2])
		#expect(series.ratings?.value == 8.5)
		#expect(series.statistics?.seasonCount == 1)
		#expect(series.statistics?.sizeOnDisk == 123_456_789)
	}

	@Test func seriesResourceDecodingWithNullableFieldsMissing() throws {
		let json = Data(
			#"""
			{
				"id": 2
			}
			"""#.utf8
		)

		let series = try client.decoder.decode(SeriesResource.self, from: json)

		#expect(series.id == 2)
		#expect(series.title == nil)
		#expect(series.alternateTitles == nil)
		#expect(series.status == nil)
		#expect(series.images == nil)
		#expect(series.seasons == nil)
		#expect(series.ratings == nil)
		#expect(series.statistics == nil)
		#expect(series.addOptions == nil)
	}

	@Test func seriesListDecoding() throws {
		let json = Data(
			#"""
			[
				{
					"id": 1,
					"title": "Some Show"
				}
			]
			"""#.utf8
		)

		let series = try client.decoder.decode([SeriesResource].self, from: json)

		#expect(series.count == 1)
		#expect(series.first?.title == "Some Show")
	}

	@Test func seriesFolderRequestConstruction() {
		let request = SonarrRequest.seriesFolder(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/series/1/folder")
	}

	@Test func seriesFolderDecoding() throws {
		let json = Data(#"{"folder": "Some Show"}"#.utf8)

		let folder = try client.decoder.decode(SeriesFolderResource.self, from: json)

		#expect(folder.folder == "Some Show")
	}

	@Test func editSeriesRequestConstruction() throws {
		let seriesEditor = SeriesEditorResource(
			seriesIds: [1, 2],
			monitored: true,
			qualityProfileId: 3,
			tags: [1],
			applyTags: .add,
			moveFiles: true
		)
		let request = SonarrRequest.editSeries(seriesEditor)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/series/editor")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["seriesIds"] as? [Int] == [1, 2])
		#expect(json["monitored"] as? Bool == true)
		#expect(json["qualityProfileId"] as? Int == 3)
		#expect(json["tags"] as? [Int] == [1])
		#expect(json["applyTags"] as? String == "add")
		#expect(json["moveFiles"] as? Bool == true)
	}

	@Test func deleteSeriesInBulkRequestConstruction() throws {
		let seriesEditor = SeriesEditorResource(seriesIds: [1, 2], deleteFiles: true, addImportListExclusion: true)
		let request = SonarrRequest.deleteSeries(inBulk: seriesEditor)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/series/editor")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["seriesIds"] as? [Int] == [1, 2])
		#expect(json["deleteFiles"] as? Bool == true)
		#expect(json["addImportListExclusion"] as? Bool == true)
	}
}
