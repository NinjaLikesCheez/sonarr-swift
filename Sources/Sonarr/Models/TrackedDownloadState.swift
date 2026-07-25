/// The stage of Sonarr's post-download processing a tracked download has reached.
public enum TrackedDownloadState: String, Equatable, Codable, Sendable {
	/// The item is still downloading.
	case downloading
	/// Import is blocked, e.g. by a manual import requirement.
	case importBlocked
	/// Import is queued but not yet started.
	case importPending
	/// The item is being imported.
	case importing
	/// The item has been imported.
	case imported
	/// A prior import attempt failed and is pending retry.
	case failedPending
	/// Import failed.
	case failed
	/// The item is being ignored, e.g. after being manually skipped.
	case ignored
}
