/// The state of a queue item's download.
public enum QueueStatus: String, Equatable, Codable, Sendable {
	/// The status could not be determined.
	case unknown
	/// The item is queued but not yet downloading.
	case queued
	/// The download is paused.
	case paused
	/// The item is downloading.
	case downloading
	/// The download has completed.
	case completed
	/// The download failed.
	case failed
	/// The download completed with a warning.
	case warning
	/// The download is delayed, e.g. waiting on a usenet retention period.
	case delay
	/// The download client used for this item is unavailable.
	case downloadClientUnavailable
	/// Sonarr fell back to a lower-priority protocol for this item.
	case fallback
}
