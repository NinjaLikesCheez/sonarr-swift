import Sonarr
import Testing

@Suite("Missing Requests", .serialized)
struct MissingRequestsTests {
	@Test
	func test_missingEpisodes() async throws {
		let page = try await client.request(.missingEpisodes())

		#expect(page.page == 1)
	}
}
