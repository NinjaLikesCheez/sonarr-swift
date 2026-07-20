import Foundation

/// A command tracked by Sonarr's task queue, either currently running or already finished.
public struct CommandResource: Equatable, Decodable, Sendable {
	/// The command's unique identifier.
	public let id: Int
	/// The command's type name, e.g. `RefreshSeries`.
	public let name: String
	/// A human-readable version of `name`, e.g. `Refresh Series`.
	public let commandName: String
	/// A status message describing the command's current progress, if any.
	public let message: String?
	/// The command's scheduling priority.
	public let priority: CommandPriority
	/// The command's current lifecycle status.
	public let status: CommandStatus
	/// The command's outcome, once finished.
	public let result: CommandResult?
	/// When the command was queued.
	public let queued: Date
	/// When the command started executing, if it has started.
	public let started: Date?
	/// When the command finished, if it has finished.
	public let ended: Date?
	/// How long the command took to run, once finished.
	public let duration: String?
	/// The exception message, if the command failed.
	public let exception: String?
	/// What caused the command to be queued.
	public let trigger: CommandTrigger
	/// Whether Sonarr pushes live progress updates for this command over its SignalR connection.
	public let sendUpdatesToClient: Bool
	/// Whether completing this command updates its associated scheduled task's last-run time.
	public let updateScheduledTask: Bool
}

/// The scheduling priority of a `CommandResource`.
public enum CommandPriority: String, Equatable, Decodable, Sendable {
	case low
	case normal
	case high
}

/// The lifecycle status of a `CommandResource`.
public enum CommandStatus: String, Equatable, Decodable, Sendable {
	case queued
	case started
	case completed
	case failed
	case aborted
	case cancelled
	case orphaned
}

/// The outcome of a finished `CommandResource`.
public enum CommandResult: String, Equatable, Decodable, Sendable {
	case unknown
	case successful
	case unsuccessful
	case indeterminate
}

/// What caused a `CommandResource` to be queued.
public enum CommandTrigger: String, Equatable, Decodable, Sendable {
	case unspecified
	case manual
	case scheduled
}
