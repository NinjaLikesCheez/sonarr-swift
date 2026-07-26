import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("LanguageProfile requests")
struct LanguageProfileRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleLanguageProfile: LanguageProfileResource {
		LanguageProfileResource(
			id: 1,
			name: "English",
			upgradeAllowed: true,
			cutoff: Language(id: 1, name: "English"),
			languages: [
				LanguageProfileItemResource(id: 1, language: Language(id: 1, name: "English"), allowed: true)
			]
		)
	}

	@available(*, deprecated)
	@Test func languageProfilesRequestConstruction() {
		let request = SonarrRequest.languageProfiles

		#expect(request.method == .get)
		#expect(request.path == "api/v3/languageprofile")
	}

	@Test func languageProfileByIdRequestConstruction() {
		let request = SonarrRequest.languageProfile(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/languageprofile/1")
	}

	@available(*, deprecated)
	@Test func addLanguageProfileRequestConstruction() throws {
		let request = SonarrRequest.addLanguageProfile(sampleLanguageProfile)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/languageprofile")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["name"] as? String == "English")
		#expect(json["upgradeAllowed"] as? Bool == true)
		#expect((json["cutoff"] as? [String: Any])?["id"] as? Int == 1)
		#expect((json["cutoff"] as? [String: Any])?["name"] as? String == "English")
		let languages = try #require(json["languages"] as? [[String: Any]])
		#expect(languages.count == 1)
		#expect(languages.first?["id"] as? Int == 1)
		#expect(languages.first?["allowed"] as? Bool == true)
		#expect((languages.first?["language"] as? [String: Any])?["id"] as? Int == 1)
		#expect((languages.first?["language"] as? [String: Any])?["name"] as? String == "English")
	}

	@available(*, deprecated)
	@Test func updateLanguageProfileRequestConstruction() throws {
		let request = SonarrRequest.updateLanguageProfile(id: 1, sampleLanguageProfile)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/languageprofile/1")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["name"] as? String == "English")
		#expect(json["upgradeAllowed"] as? Bool == true)
		#expect((json["cutoff"] as? [String: Any])?["id"] as? Int == 1)
		#expect((json["cutoff"] as? [String: Any])?["name"] as? String == "English")
		let languages = try #require(json["languages"] as? [[String: Any]])
		#expect(languages.count == 1)
		#expect(languages.first?["id"] as? Int == 1)
		#expect(languages.first?["allowed"] as? Bool == true)
		#expect((languages.first?["language"] as? [String: Any])?["id"] as? Int == 1)
		#expect((languages.first?["language"] as? [String: Any])?["name"] as? String == "English")
	}

	@available(*, deprecated)
	@Test func deleteLanguageProfileRequestConstruction() {
		let request = SonarrRequest.deleteLanguageProfile(id: 1)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/languageprofile/1")
	}

	@available(*, deprecated)
	@Test func languageProfileSchemaRequestConstruction() {
		let request = SonarrRequest.languageProfileSchema

		#expect(request.method == .get)
		#expect(request.path == "api/v3/languageprofile/schema")
	}

	@Test func languageProfileResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"name": "English",
				"upgradeAllowed": true,
				"cutoff": {
					"id": 1,
					"name": "English"
				},
				"languages": [
					{
						"id": 1,
						"language": {
							"id": 1,
							"name": "English"
						},
						"allowed": true
					}
				]
			}
			"""#.utf8
		)

		let profile = try client.decoder.decode(LanguageProfileResource.self, from: json)

		#expect(profile.id == 1)
		#expect(profile.name == "English")
		#expect(profile.upgradeAllowed == true)
		#expect(profile.cutoff == Language(id: 1, name: "English"))
		#expect(profile.languages?.count == 1)
		#expect(profile.languages?.first?.allowed == true)
	}

	@Test func languageProfileResourceDecodingWithNullableFields() throws {
		let json = Data(
			#"""
			{
				"id": 2,
				"name": null,
				"upgradeAllowed": false,
				"languages": null
			}
			"""#.utf8
		)

		let profile = try client.decoder.decode(LanguageProfileResource.self, from: json)

		#expect(profile.id == 2)
		#expect(profile.name == nil)
		#expect(profile.cutoff == nil)
		#expect(profile.languages == nil)
	}
}
