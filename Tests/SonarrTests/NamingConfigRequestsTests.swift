import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("NamingConfig requests")
struct NamingConfigRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleNamingConfig: NamingConfigResource {
		NamingConfigResource(
			id: 1,
			renameEpisodes: true,
			replaceIllegalCharacters: true,
			colonReplacementFormat: 4,
			customColonReplacementFormat: "",
			multiEpisodeStyle: 5,
			standardEpisodeFormat: "{Series Title} - S{season:00}E{episode:00} - {Episode Title}",
			dailyEpisodeFormat: "{Series Title} - {Air-Date} - {Episode Title}",
			animeEpisodeFormat: "{Series Title} - S{season:00}E{episode:00} - {Episode Title}",
			seriesFolderFormat: "{Series Title}",
			seasonFolderFormat: "Season {season}",
			specialsFolderFormat: "Specials"
		)
	}

	@Test func namingConfigRequestConstruction() {
		let request = SonarrRequest.namingConfig

		#expect(request.method == .get)
		#expect(request.path == "api/v3/config/naming")
	}

	@Test func namingConfigByIdRequestConstruction() {
		let request = SonarrRequest.namingConfig(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/config/naming/1")
	}

	@Test func updateNamingConfigRequestConstruction() throws {
		let request = SonarrRequest.updateNamingConfig(id: 1, sampleNamingConfig)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/config/naming/1")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(NamingConfigResource.self, from: try body.encode())
		#expect(decoded == sampleNamingConfig)
	}

	@Test func namingConfigExamplesRequestConstructionWithDefaults() {
		let request = SonarrRequest.namingConfigExamples()

		#expect(request.method == .get)
		#expect(request.path == "api/v3/config/naming/examples")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/config/naming/examples")!)
		let prepared = request.prepare(urlRequest)

		#expect(prepared.url?.absoluteString == "http://localhost:8989/api/v3/config/naming/examples")
	}

	@Test func namingConfigExamplesRequestConstructionWithFilters() {
		let request = SonarrRequest.namingConfigExamples(
			id: 1,
			renameEpisodes: true,
			replaceIllegalCharacters: true,
			colonReplacementFormat: 4,
			customColonReplacementFormat: "-",
			multiEpisodeStyle: 5,
			standardEpisodeFormat: "{Series Title}",
			dailyEpisodeFormat: "{Series Title} {Air-Date}",
			animeEpisodeFormat: "{Series Title} {episode}",
			seriesFolderFormat: "{Series Title}",
			seasonFolderFormat: "Season {season}",
			specialsFolderFormat: "Specials"
		)

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/config/naming/examples")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(
			components?.queryItems == [
				URLQueryItem(name: "id", value: "1"),
				URLQueryItem(name: "renameEpisodes", value: "true"),
				URLQueryItem(name: "replaceIllegalCharacters", value: "true"),
				URLQueryItem(name: "colonReplacementFormat", value: "4"),
				URLQueryItem(name: "customColonReplacementFormat", value: "-"),
				URLQueryItem(name: "multiEpisodeStyle", value: "5"),
				URLQueryItem(name: "standardEpisodeFormat", value: "{Series Title}"),
				URLQueryItem(name: "dailyEpisodeFormat", value: "{Series Title} {Air-Date}"),
				URLQueryItem(name: "animeEpisodeFormat", value: "{Series Title} {episode}"),
				URLQueryItem(name: "seriesFolderFormat", value: "{Series Title}"),
				URLQueryItem(name: "seasonFolderFormat", value: "Season {season}"),
				URLQueryItem(name: "specialsFolderFormat", value: "Specials"),
			]
		)
	}

	@Test func namingConfigResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"renameEpisodes": false,
				"replaceIllegalCharacters": true,
				"colonReplacementFormat": 4,
				"customColonReplacementFormat": "",
				"multiEpisodeStyle": 5,
				"standardEpisodeFormat": "{Series Title} - S{season:00}E{episode:00} - {Episode Title}",
				"dailyEpisodeFormat": "{Series Title} - {Air-Date} - {Episode Title}",
				"animeEpisodeFormat": "{Series Title} - S{season:00}E{episode:00} - {Episode Title}",
				"seriesFolderFormat": "{Series Title}",
				"seasonFolderFormat": "Season {season}",
				"specialsFolderFormat": "Specials"
			}
			"""#.utf8
		)

		let config = try client.decoder.decode(NamingConfigResource.self, from: json)

		#expect(config.id == 1)
		#expect(config.renameEpisodes == false)
		#expect(config.colonReplacementFormat == 4)
		#expect(config.multiEpisodeStyle == 5)
		#expect(config.seriesFolderFormat == "{Series Title}")
	}

	@Test func namingConfigResourceDecodingWithNullFields() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"customColonReplacementFormat": null,
				"standardEpisodeFormat": null,
				"dailyEpisodeFormat": null,
				"animeEpisodeFormat": null,
				"seriesFolderFormat": null,
				"seasonFolderFormat": null,
				"specialsFolderFormat": null
			}
			"""#.utf8
		)

		let config = try client.decoder.decode(NamingConfigResource.self, from: json)

		#expect(config.customColonReplacementFormat == nil)
		#expect(config.standardEpisodeFormat == nil)
		#expect(config.seriesFolderFormat == nil)
	}

	@Test func namingConfigExamplesResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"singleEpisodeExample": "The.Series.Title.S01E01.1080p.WEBDL.x264-EVOLVE",
				"multiEpisodeExample": "The.Series.Title.S01E01-E03.1080p.WEBDL.x264-EVOLVE",
				"dailyEpisodeExample": "The.Series.Title.2013.10.30.1080p.WEBDL.x264-EVOLVE",
				"animeEpisodeExample": "[RlsGroup] The Series Title - 001 [1080P]",
				"animeMultiEpisodeExample": "[RlsGroup] The Series Title - 001 - 103 [1080p]",
				"seriesFolderExample": "The Series Title",
				"seasonFolderExample": "Season 1",
				"specialsFolderExample": "Specials"
			}
			"""#.utf8
		)

		let examples = try client.decoder.decode(NamingConfigExamplesResource.self, from: json)

		#expect(examples.singleEpisodeExample == "The.Series.Title.S01E01.1080p.WEBDL.x264-EVOLVE")
		#expect(examples.seriesFolderExample == "The Series Title")
		#expect(examples.specialsFolderExample == "Specials")
	}
}
