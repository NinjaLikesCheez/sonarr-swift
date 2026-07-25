import Sonarr
import Testing

@Suite("Ping Requests", .serialized)
struct PingRequestsTests {
	@Test
	func test_ping() async throws {
		let ping = try await client.request(.ping)

		#expect(ping.status == "OK")
	}
}
