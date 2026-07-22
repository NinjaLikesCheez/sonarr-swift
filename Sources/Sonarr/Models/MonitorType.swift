/// Which episodes of a series are monitored when it's added via an import list.
public enum MonitorType: String, Equatable, Codable, Sendable {
	/// Monitoring status could not be determined.
	case unknown
	/// All episodes are monitored.
	case all
	/// Only episodes that haven't aired yet are monitored.
	case future
	/// Only episodes that have aired but haven't been downloaded are monitored.
	case missing
	/// Only episodes that have already been downloaded are monitored.
	case existing
	/// Only the first season is monitored.
	case firstSeason
	/// Only the last season is monitored.
	case lastSeason
	/// Only the most recently aired season is monitored.
	case latestSeason
	/// Only the pilot episode is monitored.
	case pilot
	/// Only recently aired episodes are monitored.
	case recent
	/// Specials are monitored.
	case monitorSpecials
	/// Specials are unmonitored.
	case unmonitorSpecials
	/// No episodes are monitored.
	case none
	/// Monitoring is left unchanged.
	case skip
}
