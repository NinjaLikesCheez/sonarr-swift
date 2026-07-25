import Sonarr
import Testing

@Suite("RenameEpisode Requests", .serialized)
struct RenameEpisodeRequestsTests {
	@Test
	func test_renames_seriesNotFound() async throws {
		// Sonarr requires a valid seriesId server-side (defaulting the omitted query param to 0
		// rather than treating it as "all series"), so a fresh instance with no series always 404s.
		await #expect(throws: (Sonarr.Error).self) {
			try await client.request(.renames())
		}
	}
}
