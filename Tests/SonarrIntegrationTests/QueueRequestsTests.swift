import Sonarr
import Testing

@Suite("Queue Requests", .serialized)
struct QueueRequestsTests {
	@Test
	func test_queue() async throws {
		let page = try await client.request(.queue())

		#expect(page.page == 1)
	}

	@Test
	func test_deleteQueueItems_empty() async throws {
		try await client.request(.deleteQueueItems(ids: []))
	}
}
