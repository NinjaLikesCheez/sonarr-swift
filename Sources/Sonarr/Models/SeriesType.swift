/// The scheduling type of a series, which affects how Sonarr matches episode files.
public enum SeriesType: String, Equatable, Codable, Sendable {
	/// A series with regular seasons and episodes.
	case standard
	/// A series that airs daily, matched by air date rather than season/episode number.
	case daily
	/// A series matched using anime-specific numbering (absolute episode numbers).
	case anime
}
