/// The monitoring strategy applied when adding or updating a series' seasons/episodes.
public enum MonitorTypes: String, Equatable, Codable, Sendable {
	/// The monitoring strategy could not be determined.
	case unknown
	/// Monitor all seasons and episodes.
	case all
	/// Monitor only episodes that haven't aired yet.
	case future
	/// Monitor only episodes missing a file.
	case missing
	/// Monitor only episodes that already have a file.
	case existing
	/// Monitor only the first season.
	case firstSeason
	/// Monitor only the last season.
	case lastSeason
	/// Monitor only the latest season.
	case latestSeason
	/// Monitor only the pilot episode.
	case pilot
	/// Monitor only recently aired episodes.
	case recent
	/// Monitor special episodes.
	case monitorSpecials
	/// Stop monitoring special episodes.
	case unmonitorSpecials
	/// Don't monitor anything.
	case none
	/// Leave monitoring state unchanged.
	case skip
}
