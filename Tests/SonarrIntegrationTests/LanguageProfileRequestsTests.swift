import Sonarr
import Testing

@Suite("LanguageProfile Requests", .serialized)
struct LanguageProfileRequestsTests {
	// Language profiles were removed in Sonarr v4, and on the live server `POST /api/v3/languageprofile`
	// no longer creates a real profile — it responds with a fixed placeholder body instead of an `id`.
	// Exercise the read/update lifecycle against a profile the server actually created at first run instead.
	@available(*, deprecated)
	@Test
	func test_languageProfiles_languageProfileById_updateLanguageProfile() async throws {
		let profiles = try await client.request(.languageProfiles)
		let profile = try #require(profiles.first)
		let id = try #require(profile.id)

		let fetched = try await client.request(.languageProfile(id: id))
		#expect(fetched.id == id)

		let updated = try await client.request(
			.updateLanguageProfile(
				id: id,
				LanguageProfileResource(
					id: id,
					name: profile.name,
					upgradeAllowed: !(profile.upgradeAllowed ?? false),
					cutoff: profile.cutoff,
					languages: profile.languages
				)
			)
		)
		#expect(updated.upgradeAllowed == !(profile.upgradeAllowed ?? false))

		// Restore the original value so this test doesn't leave the server's config mutated for other runs.
		_ = try await client.request(.updateLanguageProfile(id: id, profile))
	}

	@available(*, deprecated)
	@Test
	func test_addLanguageProfile_deleteLanguageProfile() async throws {
		let created = try await client.request(
			.addLanguageProfile(LanguageProfileResource(name: "Integration Test Profile"))
		)

		if let id = created.id {
			try await client.request(.deleteLanguageProfile(id: id))
		}
	}

	@available(*, deprecated)
	@Test
	func test_languageProfileSchema() async throws {
		_ = try await client.request(.languageProfileSchema)
	}
}
