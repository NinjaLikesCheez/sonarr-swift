/// The airing status of a series.
public enum SeriesStatusType: String, Equatable, Codable, Sendable {
	/// The series is airing new episodes.
	case continuing
	/// The series has finished airing.
	case ended
	/// The series hasn't aired yet.
	case upcoming
	/// The series has been deleted from its metadata source.
	case deleted
}
