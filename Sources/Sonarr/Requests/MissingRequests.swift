import APIClient
import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public extension SonarrRequest where SonarrResponse == PagingResource<EpisodeResource> {
	/// Gets a page of monitored episodes that have aired but have no file.
	///
	/// Endpoint: `GET /api/v3/wanted/missing`
	///
	/// Result: a page of missing episodes matching the given filters.
	///
	/// - Parameters:
	///   - page: The page number to fetch, 1-indexed.
	///   - pageSize: The number of records per page.
	///   - sortKey: The field to sort by, e.g. `airDateUtc`.
	///   - sortDirection: The direction to sort in, e.g. `ascending` or `descending`.
	///   - includeSeries: Whether to attach series details to each episode.
	///   - includeImages: Whether to attach series/episode artwork to each episode.
	///   - monitored: Restricts results to monitored (or unmonitored) episodes. Defaults to `true`.
	static func missingEpisodes(
		page: Int? = nil,
		pageSize: Int? = nil,
		sortKey: String? = nil,
		sortDirection: String? = nil,
		includeSeries: Bool = false,
		includeImages: Bool = false,
		monitored: Bool = true
	) -> SonarrRequest<PagingResource<EpisodeResource>> {
		var queryItems: [URLQueryItem] = [
			URLQueryItem(name: "includeSeries", value: String(includeSeries)),
			URLQueryItem(name: "includeImages", value: String(includeImages)),
			URLQueryItem(name: "monitored", value: String(monitored)),
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

		return SonarrRequest(method: .get, path: "api/v3/wanted/missing", queryItems: queryItems)
	}
}

public extension SonarrRequest where SonarrResponse == EpisodeResource {
	/// Gets a single missing episode.
	///
	/// Endpoint: `GET /api/v3/wanted/missing/{id}`
	///
	/// Result: the requested episode.
	///
	/// - Parameter id: The unique identifier of the episode.
	static func missingEpisode(id: Int) -> SonarrRequest<EpisodeResource> {
		SonarrRequest(method: .get, path: "api/v3/wanted/missing/\(id)")
	}
}
