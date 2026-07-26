import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("Task requests")
struct TaskRequestsTests {
	let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	@Test func tasksRequestConstruction() {
		let request = SonarrRequest.tasks

		#expect(request.method == .get)
		#expect(request.path == "api/v3/system/task")
	}

	@Test func taskRequestConstruction() {
		let request = SonarrRequest.task(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/system/task/1")
	}

	@Test func taskResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"name": "Application Update Check",
				"taskName": "ApplicationUpdateCheck",
				"interval": 720,
				"lastExecution": "2024-01-01T12:00:00Z",
				"lastStartTime": "2024-01-01T12:00:00Z",
				"nextExecution": "2024-01-01T18:00:00Z",
				"lastDuration": "00:00:01.2345678"
			}
			"""#.utf8
		)

		let task = try client.decoder.decode(TaskResource.self, from: json)

		#expect(task.id == 1)
		#expect(task.name == "Application Update Check")
		#expect(task.taskName == "ApplicationUpdateCheck")
		#expect(task.interval == 720)
		#expect(task.lastDuration == "00:00:01.2345678")
	}

	@Test func taskResourceDecodingWithNullableFieldsMissing() throws {
		let json = Data(#"{"id": 2}"#.utf8)

		let task = try client.decoder.decode(TaskResource.self, from: json)

		#expect(task.id == 2)
		#expect(task.name == nil)
		#expect(task.taskName == nil)
		#expect(task.interval == nil)
		#expect(task.lastExecution == nil)
		#expect(task.lastStartTime == nil)
		#expect(task.nextExecution == nil)
		#expect(task.lastDuration == nil)
	}

	@Test func taskResourceListDecoding() throws {
		let json = Data(#"[{"id": 1, "name": "Application Update Check"}]"#.utf8)

		let tasks = try client.decoder.decode([TaskResource].self, from: json)

		#expect(tasks.count == 1)
		#expect(tasks.first?.name == "Application Update Check")
	}
}
