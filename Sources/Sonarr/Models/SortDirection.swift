/// The direction records are sorted in on a paginated endpoint.
public enum SortDirection: String, Equatable, Codable, Sendable {
	/// The server's default sort direction for the requested `sortKey`.
	case `default`
	/// Ascending order.
	case ascending
	/// Descending order.
	case descending
}
