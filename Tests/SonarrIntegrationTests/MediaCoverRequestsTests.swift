import Sonarr
import Testing

@Suite("MediaCover Requests", .serialized)
struct MediaCoverRequestsTests {
	@Test
	func test_mediaCover_notFound() async throws {
		// No series exist on the test server, so this exercises the request reaching the endpoint and
		// the server's 404 being surfaced as a typed error, rather than the raw-data transform (which only
		// runs on a successful response).
		await #expect(throws: (Sonarr.Error).self) {
			_ = try await client.request(.mediaCover(seriesId: 1, filename: "poster.jpg"))
		}
	}
}
