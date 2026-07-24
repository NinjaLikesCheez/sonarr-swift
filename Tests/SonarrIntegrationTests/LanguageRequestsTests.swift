import Sonarr
import Testing

@Suite("Language Requests", .serialized)
struct LanguageRequestsTests {
	@Test
	func test_languages_languageById() async throws {
		let languages = try await client.request(.languages)
		#expect(!languages.isEmpty)

		let id = try #require(languages.first?.id)

		let language = try await client.request(.language(id: id))
		#expect(language.id == id)
	}
}
