/// The category of source an import list implementation pulls series from.
public enum ImportListType: String, Equatable, Codable, Sendable {
	/// A program-driven list, e.g. another *arr instance.
	case program
	/// A Plex watchlist.
	case plex
	/// A Trakt list.
	case trakt
	/// A Simkl list.
	case simkl
	/// A list type not covered by the other cases.
	case other
	/// An advanced/custom list.
	case advanced
}
