import Sonarr
import Testing

@Suite("SeasonPass Requests", .serialized)
struct SeasonPassRequestsTests {
	@Test
	func test_updateSeasonPass_empty() async throws {
		try await client.request(.updateSeasonPass(SeasonPassResource(series: [])))
	}
}
