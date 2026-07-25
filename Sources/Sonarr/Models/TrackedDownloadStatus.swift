/// The overall health of a tracked download.
public enum TrackedDownloadStatus: String, Equatable, Codable, Sendable {
	/// The download is progressing normally.
	case ok
	/// The download has a non-fatal issue.
	case warning
	/// The download has a fatal issue.
	case error
}
