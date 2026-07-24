import Sonarr
import Testing

@Suite("Localization Requests", .serialized)
struct LocalizationRequestsTests {
	// The server omits `id` entirely from these responses, and `GET .../{id}` ignores the id
	// parameter and always returns the current localization, so there's nothing to correlate by id here.
	@Test
	func test_localization_localizationById() async throws {
		let localization = try await client.request(.localization)
		#expect(!(localization.strings ?? [:]).isEmpty)

		let fetched = try await client.request(.localization(id: 1))
		#expect(!(fetched.strings ?? [:]).isEmpty)
	}

	@Test
	func test_localizationLanguage() async throws {
		_ = try await client.request(.localizationLanguage)
	}
}
