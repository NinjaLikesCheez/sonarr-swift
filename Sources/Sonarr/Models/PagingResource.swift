/// A page of records returned by a paginated Sonarr endpoint.
public struct PagingResource<Record: Equatable & Decodable & Sendable>: Equatable, Decodable, Sendable {
	/// The current page number, 1-indexed.
	public let page: Int
	/// The number of records per page.
	public let pageSize: Int
	/// The field records are sorted by, or `nil` when no explicit sort was requested.
	public let sortKey: String?
	/// The direction records are sorted in.
	public let sortDirection: SortDirection
	/// The total number of records across all pages.
	public let totalRecords: Int
	/// The records on this page, or `nil` when the server omits them.
	public let records: [Record]?
}
