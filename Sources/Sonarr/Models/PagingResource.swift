/// A page of records returned by a paginated Sonarr endpoint.
public struct PagingResource<Record: Equatable & Decodable & Sendable>: Equatable, Decodable, Sendable {
	/// The current page number, 1-indexed.
	public let page: Int
	/// The number of records per page.
	public let pageSize: Int
	/// The field records are sorted by.
	public let sortKey: String
	/// The direction records are sorted in, e.g. `ascending` or `descending`.
	public let sortDirection: String
	/// The total number of records across all pages.
	public let totalRecords: Int
	/// The records on this page.
	public let records: [Record]
}
