import Foundation

/// A log file available on the Sonarr server.
public struct LogFileResource: Equatable, Decodable, Sendable {
	/// The unique identifier of this log file.
	public let id: Int?
	/// The name of the log file, e.g. `sonarr.txt`.
	public let filename: String?
	/// The date and time the log file was last written to.
	public let lastWriteTime: Date?
	/// The URL to fetch this log file's contents from.
	public let contentsUrl: String?
	/// The URL to download this log file from.
	public let downloadUrl: String?
}
