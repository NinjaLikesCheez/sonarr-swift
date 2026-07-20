import APIClient
import Foundation

public extension SonarrRequest where SonarrResponse == PagingResource<Blocklist> {
	/// Gets a page of blocklisted releases.
	///
	/// Endpoint: `GET /api/v3/blocklist`
	///
	/// Result: a page of blocklist entries matching the given filters.
	///
	/// - Parameters:
	///   - page: The page number to fetch, 1-indexed.
	///   - pageSize: The number of records per page.
	///   - sortKey: The field to sort by, e.g. `date`.
	///   - sortDirection: The direction to sort in, e.g. `ascending` or `descending`.
	///   - seriesIds: Restricts results to entries belonging to the given series.
	///   - protocols: Restricts results to entries fetched via the given download protocols.
	static func blocklist(
		page: Int? = nil,
		pageSize: Int? = nil,
		sortKey: String? = nil,
		sortDirection: String? = nil,
		seriesIds: [Int] = [],
		protocols: [DownloadProtocol] = []
	) -> SonarrRequest<PagingResource<Blocklist>> {
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

		queryItems += seriesIds.map { URLQueryItem(name: "seriesIds", value: String($0)) }
		queryItems += protocols.map { URLQueryItem(name: "protocols", value: $0.rawValue) }

		return SonarrRequest(method: .get, path: "api/v3/blocklist", queryItems: queryItems)
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Removes a blocklisted release.
	///
	/// Endpoint: `DELETE /api/v3/blocklist/{id}`
	///
	/// - Parameter id: The identifier of the blocklist entry to remove.
	static func deleteBlocklistEntry(id: Int) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .delete, path: "api/v3/blocklist/\(id)")
	}

	/// Removes multiple blocklisted releases in a single request.
	///
	/// Endpoint: `DELETE /api/v3/blocklist/bulk`
	///
	/// - Parameter ids: The identifiers of the blocklist entries to remove.
	static func deleteBlocklistEntries(ids: [Int]) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(
			method: .delete,
			path: "api/v3/blocklist/bulk",
			body: { JSONBody(BlocklistBulkResource(ids: ids)) }
		)
	}
}
