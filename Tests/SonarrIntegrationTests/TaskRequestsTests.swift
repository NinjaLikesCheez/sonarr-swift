import Sonarr
import Testing

@Suite("Task Requests", .serialized)
struct TaskRequestsTests {
	@Test
	func test_tasks_task() async throws {
		let tasks = try await client.request(.tasks)
		let firstTask = try #require(tasks.first)
		let id = try #require(firstTask.id)

		let fetched = try await client.request(.task(id: id))
		#expect(fetched.id == id)
	}
}
