/// The category of source an import list implementation pulls series from.
public enum ImportListType: String, Equatable, Codable, Sendable {
	/// A list sourced from another *arr program instance.
	case program
	/// A list sourced from a Plex watchlist or server.
	case plex
	/// A list sourced from Trakt.
	case trakt
	/// A list sourced from Simkl.
	case simkl
	/// A list sourced from a generic/other provider.
	case other
	/// A list configured using advanced custom settings.
	case advanced
}
