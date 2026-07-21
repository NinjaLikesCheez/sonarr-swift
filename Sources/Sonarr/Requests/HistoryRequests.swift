import APIClient
import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public extension SonarrRequest where SonarrResponse == PagingResource<HistoryResource> {
	/// Gets a page of history events.
	///
	/// Endpoint: `GET /api/v3/history`
	///
	/// Result: a page of history events matching the given filters.
	///
	/// - Parameters:
	///   - page: The page number to fetch, 1-indexed.
	///   - pageSize: The number of records per page.
	///   - sortKey: The field to sort by, e.g. `date`.
	///   - sortDirection: The direction to sort in, e.g. `ascending` or `descending`.
	///   - includeSeries: Whether to attach series details to each event.
	///   - includeEpisode: Whether to attach episode details to each event.
	///   - eventTypes: Restricts results to events of the given types.
	///   - episodeId: Restricts results to events for the given episode.
	///   - downloadId: Restricts results to events for the given download client identifier.
	///   - seriesIds: Restricts results to events belonging to the given series.
	///   - languages: Restricts results to events matching the given language identifiers.
	///   - quality: Restricts results to events matching the given quality identifiers.
	static func history(
		page: Int? = nil,
		pageSize: Int? = nil,
		sortKey: String? = nil,
		sortDirection: String? = nil,
		includeSeries: Bool = false,
		includeEpisode: Bool = false,
		eventTypes: [EpisodeHistoryEventType] = [],
		episodeId: Int? = nil,
		downloadId: String? = nil,
		seriesIds: [Int] = [],
		languages: [Int] = [],
		quality: [Int] = []
	) -> SonarrRequest<PagingResource<HistoryResource>> {
		var queryItems: [URLQueryItem] = [
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

		if let episodeId {
			queryItems.append(URLQueryItem(name: "episodeId", value: String(episodeId)))
		}

		if let downloadId {
			queryItems.append(URLQueryItem(name: "downloadId", value: downloadId))
		}

		queryItems += eventTypes.map { URLQueryItem(name: "eventType", value: String(eventTypeRawValue($0))) }
		queryItems += seriesIds.map { URLQueryItem(name: "seriesIds", value: String($0)) }
		queryItems += languages.map { URLQueryItem(name: "languages", value: String($0)) }
		queryItems += quality.map { URLQueryItem(name: "quality", value: String($0)) }

		return SonarrRequest(method: .get, path: "api/v3/history", queryItems: queryItems)
	}

	// Sonarr's OpenAPI spec models `/history`'s `eventType` filter as an array of the enum's
	// underlying integer indices rather than its string values, unlike `/history/since` and
	// `/history/series` which take the string enum directly.
	private static func eventTypeRawValue(_ eventType: EpisodeHistoryEventType) -> Int {
		EpisodeHistoryEventType.allCases.firstIndex(of: eventType) ?? 0
	}
}

public extension SonarrRequest where SonarrResponse == [HistoryResource] {
	/// Gets history events that occurred since a given date.
	///
	/// Endpoint: `GET /api/v3/history/since`
	///
	/// Result: the history events occurring on or after `date`, matching the given filters.
	///
	/// - Parameters:
	///   - date: Restricts results to events on or after this date.
	///   - eventType: Restricts results to events of the given type.
	///   - includeSeries: Whether to attach series details to each event.
	///   - includeEpisode: Whether to attach episode details to each event.
	static func historySince(
		date: Date? = nil,
		eventType: EpisodeHistoryEventType? = nil,
		includeSeries: Bool = false,
		includeEpisode: Bool = false
	) -> SonarrRequest<[HistoryResource]> {
		var queryItems: [URLQueryItem] = [
			URLQueryItem(name: "includeSeries", value: String(includeSeries)),
			URLQueryItem(name: "includeEpisode", value: String(includeEpisode)),
		]

		if let date {
			queryItems.append(URLQueryItem(name: "date", value: ISO8601DateFormatter().string(from: date)))
		}

		if let eventType {
			queryItems.append(URLQueryItem(name: "eventType", value: eventType.rawValue))
		}

		return SonarrRequest(method: .get, path: "api/v3/history/since", queryItems: queryItems)
	}

	/// Gets history events for a series.
	///
	/// Endpoint: `GET /api/v3/history/series`
	///
	/// Result: the history events for the given series, matching the given filters.
	///
	/// - Parameters:
	///   - seriesId: Restricts results to events belonging to the given series.
	///   - seasonNumber: Restricts results to events belonging to the given season.
	///   - eventType: Restricts results to events of the given type.
	///   - includeSeries: Whether to attach series details to each event.
	///   - includeEpisode: Whether to attach episode details to each event.
	static func historyForSeries(
		seriesId: Int? = nil,
		seasonNumber: Int? = nil,
		eventType: EpisodeHistoryEventType? = nil,
		includeSeries: Bool = false,
		includeEpisode: Bool = false
	) -> SonarrRequest<[HistoryResource]> {
		var queryItems: [URLQueryItem] = [
			URLQueryItem(name: "includeSeries", value: String(includeSeries)),
			URLQueryItem(name: "includeEpisode", value: String(includeEpisode)),
		]

		if let seriesId {
			queryItems.append(URLQueryItem(name: "seriesId", value: String(seriesId)))
		}

		if let seasonNumber {
			queryItems.append(URLQueryItem(name: "seasonNumber", value: String(seasonNumber)))
		}

		if let eventType {
			queryItems.append(URLQueryItem(name: "eventType", value: eventType.rawValue))
		}

		return SonarrRequest(method: .get, path: "api/v3/history/series", queryItems: queryItems)
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Marks a history event as failed.
	///
	/// Endpoint: `POST /api/v3/history/failed/{id}`
	///
	/// - Parameter id: The unique identifier of the history event to mark as failed.
	static func markHistoryEventAsFailed(id: Int) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .post, path: "api/v3/history/failed/\(id)")
	}
}
