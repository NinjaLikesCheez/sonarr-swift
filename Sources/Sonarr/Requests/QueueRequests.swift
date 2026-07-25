import APIClient
import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public extension SonarrRequest where SonarrResponse == PagingResource<QueueResource> {
	/// Gets a page of the download queue.
	///
	/// Endpoint: `GET /api/v3/queue`
	///
	/// Result: a page of queue items matching the given filters.
	///
	/// - Parameters:
	///   - page: The page number to fetch, 1-indexed.
	///   - pageSize: The number of records per page.
	///   - sortKey: The field to sort by, e.g. `timeleft`.
	///   - sortDirection: The direction to sort in, e.g. `ascending` or `descending`.
	///   - includeUnknownSeriesItems: Whether to include queue items not associated with a known series.
	///   - includeSeries: Whether to attach series details to each item.
	///   - includeEpisode: Whether to attach episode details to each item.
	///   - seriesIds: Restricts results to items belonging to the given series.
	///   - protocol: Restricts results to items fetched via the given download protocol.
	///   - languages: Restricts results to items matching the given language identifiers.
	///   - quality: Restricts results to items matching the given quality identifiers.
	///   - status: Restricts results to items in the given queue statuses.
	static func queue(
		page: Int? = nil,
		pageSize: Int? = nil,
		sortKey: String? = nil,
		sortDirection: String? = nil,
		includeUnknownSeriesItems: Bool = false,
		includeSeries: Bool = false,
		includeEpisode: Bool = false,
		seriesIds: [Int] = [],
		protocol: DownloadProtocol? = nil,
		languages: [Int] = [],
		quality: [Int] = [],
		status: [QueueStatus] = []
	) -> SonarrRequest<PagingResource<QueueResource>> {
		var queryItems: [URLQueryItem] = [
			URLQueryItem(name: "includeUnknownSeriesItems", value: String(includeUnknownSeriesItems)),
			URLQueryItem(name: "includeSeries", value: String(includeSeries)),
			URLQueryItem(name: "includeEpisode", value: String(includeEpisode)),
		]

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

		if let `protocol` {
			queryItems.append(URLQueryItem(name: "protocol", value: `protocol`.rawValue))
		}

		queryItems += seriesIds.map { URLQueryItem(name: "seriesIds", value: String($0)) }
		queryItems += languages.map { URLQueryItem(name: "languages", value: String($0)) }
		queryItems += quality.map { URLQueryItem(name: "quality", value: String($0)) }
		queryItems += status.map { URLQueryItem(name: "status", value: $0.rawValue) }

		return SonarrRequest(method: .get, path: "api/v3/queue", queryItems: queryItems)
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Removes an item from the download queue.
	///
	/// Endpoint: `DELETE /api/v3/queue/{id}`
	///
	/// - Parameters:
	///   - id: The identifier of the queue item to remove.
	///   - removeFromClient: Whether to also remove the download from the download client.
	///   - blocklist: Whether to blocklist the release so it isn't grabbed again.
	///   - skipRedownload: Whether to skip searching for a replacement download.
	///   - changeCategory: Whether to change the download client category to the failed/completed
	///   category before removing.
	static func deleteQueueItem(
		id: Int,
		removeFromClient: Bool = true,
		blocklist: Bool = false,
		skipRedownload: Bool = false,
		changeCategory: Bool = false
	) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(
			method: .delete,
			path: "api/v3/queue/\(id)",
			queryItems: [
				URLQueryItem(name: "removeFromClient", value: String(removeFromClient)),
				URLQueryItem(name: "blocklist", value: String(blocklist)),
				URLQueryItem(name: "skipRedownload", value: String(skipRedownload)),
				URLQueryItem(name: "changeCategory", value: String(changeCategory)),
			]
		)
	}

	/// Removes multiple items from the download queue in a single request.
	///
	/// Endpoint: `DELETE /api/v3/queue/bulk`
	///
	/// - Parameters:
	///   - ids: The identifiers of the queue items to remove.
	///   - removeFromClient: Whether to also remove the downloads from the download client.
	///   - blocklist: Whether to blocklist the releases so they aren't grabbed again.
	///   - skipRedownload: Whether to skip searching for replacement downloads.
	///   - changeCategory: Whether to change the download client category to the failed/completed
	///   category before removing.
	static func deleteQueueItems(
		ids: [Int],
		removeFromClient: Bool = true,
		blocklist: Bool = false,
		skipRedownload: Bool = false,
		changeCategory: Bool = false
	) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(
			method: .delete,
			path: "api/v3/queue/bulk",
			queryItems: [
				URLQueryItem(name: "removeFromClient", value: String(removeFromClient)),
				URLQueryItem(name: "blocklist", value: String(blocklist)),
				URLQueryItem(name: "skipRedownload", value: String(skipRedownload)),
				URLQueryItem(name: "changeCategory", value: String(changeCategory)),
			],
			body: { JSONBody(QueueBulkResource(ids: ids)) }
		)
	}
}
