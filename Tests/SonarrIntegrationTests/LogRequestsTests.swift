import Sonarr
import Testing

@Suite("Log Requests", .serialized)
struct LogRequestsTests {
	@Test
	func test_logs() async throws {
		let page = try await client.request(.logs(pageSize: 1))

		#expect(page.page == 1)
	}
}
