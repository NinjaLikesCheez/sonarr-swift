import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("Language requests")
struct LanguageRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	@Test func languagesRequestConstruction() {
		let request = SonarrRequest.languages

		#expect(request.method == .get)
		#expect(request.path == "api/v3/language")
	}

	@Test func languageByIdRequestConstruction() {
		let request = SonarrRequest.language(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/language/1")
	}

	@Test func languageResourceListDecoding() throws {
		let json = Data(
			#"""
			[
				{
					"id": 1,
					"name": "English",
					"nameLower": "english"
				}
			]
			"""#.utf8
		)

		let languages = try client.decoder.decode([LanguageResource].self, from: json)

		#expect(languages.count == 1)

		let language = try #require(languages.first)
		#expect(language.id == 1)
		#expect(language.name == "English")
		#expect(language.nameLower == "english")
	}

	@Test func languageResourceDecodingWithNullableFields() throws {
		let json = Data(
			#"""
			{
				"id": 2,
				"name": null,
				"nameLower": null
			}
			"""#.utf8
		)

		let language = try client.decoder.decode(LanguageResource.self, from: json)

		#expect(language.id == 2)
		#expect(language.name == nil)
		#expect(language.nameLower == nil)
	}
}
