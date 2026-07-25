import Sonarr
import Testing

@Suite("NamingConfig Requests", .serialized)
struct NamingConfigRequestsTests {
	@Test
	func test_namingConfig_namingConfigById_updateNamingConfig() async throws {
		let config = try await client.request(.namingConfig)
		let id = try #require(config.id)

		let fetched = try await client.request(.namingConfig(id: id))
		#expect(fetched.id == id)

		let toggled = NamingConfigResource(
			id: id,
			renameEpisodes: !(config.renameEpisodes ?? false),
			replaceIllegalCharacters: config.replaceIllegalCharacters,
			colonReplacementFormat: config.colonReplacementFormat,
			customColonReplacementFormat: config.customColonReplacementFormat,
			multiEpisodeStyle: config.multiEpisodeStyle,
			standardEpisodeFormat: config.standardEpisodeFormat,
			dailyEpisodeFormat: config.dailyEpisodeFormat,
			animeEpisodeFormat: config.animeEpisodeFormat,
			seriesFolderFormat: config.seriesFolderFormat,
			seasonFolderFormat: config.seasonFolderFormat,
			specialsFolderFormat: config.specialsFolderFormat
		)

		let updated = try await client.request(.updateNamingConfig(id: id, toggled))
		#expect(updated.renameEpisodes == toggled.renameEpisodes)

		// Restore the original value so this test doesn't leave the server's config mutated for other runs.
		_ = try await client.request(.updateNamingConfig(id: id, config))
	}

	@Test
	func test_namingConfigExamples() async throws {
		let examples = try await client.request(.namingConfigExamples())

		#expect(examples.singleEpisodeExample != nil)
	}
}
