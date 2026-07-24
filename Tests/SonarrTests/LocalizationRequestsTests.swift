import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("Localization requests")
struct LocalizationRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	@Test func localizationRequestConstruction() {
		let request = SonarrRequest.localization

		#expect(request.method == .get)
		#expect(request.path == "api/v3/localization")
	}

	@Test func localizationByIdRequestConstruction() {
		let request = SonarrRequest.localization(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/localization/1")
	}

	@Test func localizationLanguageRequestConstruction() {
		let request = SonarrRequest.localizationLanguage

		#expect(request.method == .get)
		#expect(request.path == "api/v3/localization/language")
	}

	@Test func localizationResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"strings": {
					"settings": "Settings",
					"series": "Series"
				}
			}
			"""#.utf8
		)

		let localization = try client.decoder.decode(LocalizationResource.self, from: json)

		#expect(localization.id == 1)
		#expect(localization.strings?["settings"] == "Settings")
		#expect(localization.strings?["series"] == "Series")
	}

	@Test func localizationResourceDecodingWithNullableFields() throws {
		let json = Data(
			#"""
			{
				"id": 2,
				"strings": null
			}
			"""#.utf8
		)

		let localization = try client.decoder.decode(LocalizationResource.self, from: json)

		#expect(localization.id == 2)
		#expect(localization.strings == nil)
	}

	@Test func localizationLanguageResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"identifier": "en"
			}
			"""#.utf8
		)

		let language = try client.decoder.decode(LocalizationLanguageResource.self, from: json)

		#expect(language.identifier == "en")
	}

	@Test func localizationLanguageResourceDecodingWithNullableFields() throws {
		let json = Data(
			#"""
			{
				"identifier": null
			}
			"""#.utf8
		)

		let language = try client.decoder.decode(LocalizationLanguageResource.self, from: json)

		#expect(language.identifier == nil)
	}
}
