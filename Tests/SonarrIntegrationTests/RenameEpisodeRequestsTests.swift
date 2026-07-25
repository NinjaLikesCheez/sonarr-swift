import Sonarr
import Testing

@Suite("RenameEpisode Requests", .serialized)
struct RenameEpisodeRequestsTests {
	@Test
	func test_renames() async throws {
		try await client.request(.renames())
	}
}
