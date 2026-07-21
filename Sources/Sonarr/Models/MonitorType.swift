/// Which episodes of a series should be monitored.
public enum MonitorType: String, Equatable, Codable, Sendable {
	/// The monitor state could not be determined.
	case unknown
	/// Monitor all episodes.
	case all
	/// Monitor only episodes that haven't aired yet.
	case future
	/// Monitor only episodes missing from disk.
	case missing
	/// Monitor only episodes already on disk.
	case existing
	/// Monitor only the first season.
	case firstSeason
	/// Monitor only the last season.
	case lastSeason
	/// Monitor only the most recent season.
	case latestSeason
	/// Monitor only the pilot episode.
	case pilot
	/// Monitor only recently aired episodes.
	case recent
	/// Monitor only special episodes.
	case monitorSpecials
	/// Unmonitor special episodes.
	case unmonitorSpecials
	/// Monitor no episodes.
	case none
	/// Skip monitoring entirely.
	case skip
}
