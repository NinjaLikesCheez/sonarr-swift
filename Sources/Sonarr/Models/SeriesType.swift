/// The parsing/organizational style Sonarr applies to a series.
public enum SeriesType: String, Equatable, Codable, Sendable {
	/// A standard season/episode-numbered series.
	case standard
	/// A series aired and numbered by broadcast date.
	case daily
	/// An anime series, which may use absolute episode numbering.
	case anime
}
