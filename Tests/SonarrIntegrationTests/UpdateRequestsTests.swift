import Sonarr
import Testing

@Suite("Update Requests", .serialized)
struct UpdateRequestsTests {
	@Test
	func test_updates() async throws {
		try await client.request(.updates)
	}
}
