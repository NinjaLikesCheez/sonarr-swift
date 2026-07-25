import Sonarr
import Testing

@Suite("Release Requests", .serialized)
struct ReleaseRequestsTests {
	@Test
	func test_releases() async throws {
		try await client.request(.releases())
	}
}
