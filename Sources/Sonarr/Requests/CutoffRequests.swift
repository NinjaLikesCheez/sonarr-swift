import APIClient
import Foundation

public extension SonarrRequest where SonarrResponse == PagingResource<EpisodeResource> {
	/// Gets a page of episodes that haven't met their quality cutoff.
	///
	/// Endpoint: `GET /api/v3/wanted/cutoff`
	///
	/// Result: a page of episodes below their quality cutoff, matching the given filters.
	///
	/// - Parameters:
	///   - page: The page number to fetch, 1-indexed.
	///   - pageSize: The number of records per page.
	///   - sortKey: The field to sort by, e.g. `airDateUtc`.
	///   - sortDirection: The direction to sort in, e.g. `ascending` or `descending`.
	///   - includeSeries: Whether to attach series details to each episode.
	///   - includeEpisodeFile: Whether to attach episode file details to each episode.
	///   - includeImages: Whether to attach artwork to each episode.
	///   - monitored: Whether to restrict results to monitored episodes.
	static func cutoff(
		page: Int? = nil,
		pageSize: Int? = nil,
		sortKey: String? = nil,
		sortDirection: String? = nil,
		includeSeries: Bool = false,
		includeEpisodeFile: Bool = false,
		includeImages: Bool = false,
		monitored: Bool? = nil
	) -> SonarrRequest<PagingResource<EpisodeResource>> {
		var queryItems: [URLQueryItem] = [
			URLQueryItem(name: "includeSeries", value: String(includeSeries)),
			URLQueryItem(name: "includeEpisodeFile", value: String(includeEpisodeFile)),
			URLQueryItem(name: "includeImages", value: String(includeImages)),
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

		if let monitored {
			queryItems.append(URLQueryItem(name: "monitored", value: String(monitored)))
		}

		return SonarrRequest(method: .get, path: "api/v3/wanted/cutoff", queryItems: queryItems)
	}
}

public extension SonarrRequest where SonarrResponse == EpisodeResource {
	/// Gets a single episode that hasn't met its quality cutoff.
	///
	/// Endpoint: `GET /api/v3/wanted/cutoff/{id}`
	///
	/// Result: the requested episode.
	///
	/// - Parameter id: The unique identifier of the episode.
	static func cutoffEntry(id: Int) -> SonarrRequest<EpisodeResource> {
		SonarrRequest(method: .get, path: "api/v3/wanted/cutoff/\(id)")
	}
}
