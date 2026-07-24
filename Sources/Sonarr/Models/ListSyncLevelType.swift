/// The level of synchronization Sonarr applies when a series is removed from an import list.
public enum ListSyncLevelType: String, Equatable, Codable, Sendable {
	/// List synchronization is disabled.
	case disabled
	/// Removals are logged only; no action is taken on the series.
	case logOnly
	/// The series is kept but unmonitored.
	case keepAndUnmonitor
	/// The series is kept, unmonitored, and tagged.
	case keepAndTag
}
