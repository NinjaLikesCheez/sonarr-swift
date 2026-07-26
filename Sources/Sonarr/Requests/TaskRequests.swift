import APIClient
import Foundation

public extension SonarrRequest where SonarrResponse == [TaskResource] {
	/// Gets all of Sonarr's scheduled background tasks.
	///
	/// Endpoint: `GET /api/v3/system/task`
	///
	/// Result: the scheduled tasks.
	static var tasks: SonarrRequest<[TaskResource]> {
		SonarrRequest(method: .get, path: "api/v3/system/task")
	}
}

public extension SonarrRequest where SonarrResponse == TaskResource {
	/// Gets a single scheduled background task.
	///
	/// Endpoint: `GET /api/v3/system/task/{id}`
	///
	/// Result: the requested task.
	///
	/// - Parameter id: The unique identifier of the task.
	static func task(id: Int) -> SonarrRequest<TaskResource> {
		SonarrRequest(method: .get, path: "api/v3/system/task/\(id)")
	}
}
