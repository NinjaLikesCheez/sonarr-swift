import Sonarr
import Testing

@Suite("LanguageProfile Requests", .serialized)
struct LanguageProfileRequestsTests {
	@available(*, deprecated)
	@Test
	func test_addLanguageProfile_languageProfile_updateLanguageProfile_deleteLanguageProfile() async throws {
		let languages = try await client.request(.languages)
		let english = try #require(languages.first)

		let created = try await client.request(
			.addLanguageProfile(
				LanguageProfileResource(
					name: "Integration Test Profile",
					upgradeAllowed: false,
					cutoff: Language(id: english.id ?? 1, name: english.name ?? "English"),
					languages: [
						LanguageProfileItemResource(
							language: Language(id: english.id ?? 1, name: english.name ?? "English"),
							allowed: true
						)
					]
				)
			)
		)

		let id = try #require(created.id)
		#expect(created.name == "Integration Test Profile")

		let fetched = try await client.request(.languageProfile(id: id))
		#expect(fetched.id == id)

		let updated = try await client.request(
			.updateLanguageProfile(
				id: id,
				LanguageProfileResource(
					id: id,
					name: "Integration Test Profile Renamed",
					upgradeAllowed: created.upgradeAllowed,
					cutoff: created.cutoff,
					languages: created.languages
				)
			)
		)
		#expect(updated.name == "Integration Test Profile Renamed")

		try await client.request(.deleteLanguageProfile(id: id))

		let remaining = try await client.request(.languageProfiles)
		#expect(!remaining.contains(where: { $0.id == id }))
	}
}
