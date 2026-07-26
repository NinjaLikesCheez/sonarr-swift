import Foundation

/// A scheduled background task Sonarr runs periodically.
public struct TaskResource: Equatable, Decodable, Sendable {
	/// Sonarr's internal identifier for this task.
	public let id: Int?
	/// The user-facing name of the task.
	public let name: String?
	/// The internal name of the task's implementation.
	public let taskName: String?
	/// How often the task runs, in minutes.
	public let interval: Int?
	/// When the task last ran.
	public let lastExecution: Date?
	/// When the task's last run started.
	public let lastStartTime: Date?
	/// When the task is next scheduled to run.
	public let nextExecution: Date?
	// Unlike QueueResource.timeleft (also a `date-span`-formatted string, but marked `deprecated`
	// in the spec and omitted from that model entirely), `lastDuration` is this resource's primary,
	// actively-used field for surfacing how long a task took - dropping it would lose information
	// callers plausibly want. There's no TimeSpan-parsing precedent anywhere else in the codebase, so
	// this keeps the raw wire format rather than adding a one-off custom decoder for a single field.
	/// How long the task's last run took, as a .NET `TimeSpan`-formatted string (e.g. `00:05:23.1234567`).
	public let lastDuration: String?
}
