/// The source used to set an imported episode file's modified date.
public enum FileDateType: String, Equatable, Codable, Sendable {
	/// The file's date is left unchanged.
	case none
	/// The file's date is set to the episode's air date, in local time.
	case localAirDate
	/// The file's date is set to the episode's air date, in UTC.
	case utcAirDate
}
