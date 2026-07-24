import Foundation

/// A single entry from Sonarr's log.
public struct LogResource: Equatable, Decodable, Sendable {
	/// The unique identifier of this log entry.
	public let id: Int?
	/// The date and time the entry was logged.
	public let time: Date?
	/// The exception message, if this entry represents an error.
	public let exception: String?
	/// The exception's type name, if this entry represents an error.
	public let exceptionType: String?
	/// The severity of this entry, e.g. `info` or `error`.
	public let level: String?
	/// The name of the logger that produced this entry.
	public let logger: String?
	/// The log message.
	public let message: String?
	/// The name of the method that produced this entry.
	public let method: String?
}
