import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public extension SonarrRequest where SonarrResponse == PagingResource<LogResource> {
	/// Gets a page of log entries.
	///
	/// Endpoint: `GET /api/v3/log`
	///
	/// Result: a page of log entries matching the given filters.
	///
	/// - Parameters:
	///   - page: The page number to fetch, 1-indexed.
	///   - pageSize: The number of records per page.
	///   - sortKey: The field to sort by, e.g. `time`.
	///   - sortDirection: The direction to sort in, e.g. `ascending` or `descending`.
	///   - level: Restricts results to entries at or above this severity, e.g. `info` or `error`.
	static func logs(
		page: Int? = nil,
		pageSize: Int? = nil,
		sortKey: String? = nil,
		sortDirection: String? = nil,
		level: String? = nil
	) -> SonarrRequest<PagingResource<LogResource>> {
		var queryItems: [URLQueryItem] = []

		if let page {
			queryItems.append(URLQueryItem(name: "page", value: String(page)))
		}

		if let pageSize {
			queryItems.append(URLQueryItem(name: "pageSize", value: String(pageSize)))
		}

		if let sortKey {
			queryItems.append(URLQueryItem(name: "sortKey", value: sortKey))
		}

		if let sortDirection {
			queryItems.append(URLQueryItem(name: "sortDirection", value: sortDirection))
		}

		if let level {
			queryItems.append(URLQueryItem(name: "level", value: level))
		}

		return SonarrRequest(method: .get, path: "api/v3/log", queryItems: queryItems)
	}
}
