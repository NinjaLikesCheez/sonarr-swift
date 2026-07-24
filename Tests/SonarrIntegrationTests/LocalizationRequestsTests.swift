import Sonarr
import Testing

@Suite("Localization Requests", .serialized)
struct LocalizationRequestsTests {
	@Test
	func test_localization_localizationById() async throws {
		let localization = try await client.request(.localization)
		let id = try #require(localization.id)

		let fetched = try await client.request(.localization(id: id))
		#expect(fetched.id == id)
	}

	@Test
	func test_localizationLanguage() async throws {
		_ = try await client.request(.localizationLanguage)
	}
}
