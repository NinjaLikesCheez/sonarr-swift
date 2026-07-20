import APIClient
import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public extension SonarrRequest where SonarrResponse == [EpisodeResource] {
	/// Gets the episodes airing within a date range.
	///
	/// Endpoint: `GET /api/v3/calendar`
	///
	/// Result: the episodes airing between `start` and `end`, ordered by air date.
	///
	/// - Parameters:
	///   - start: The beginning of the date range. Defaults to today on the server if omitted.
	///   - end: The end of the date range. Defaults to two days from today on the server if omitted.
	///   - unmonitored: Whether to include unmonitored episodes.
	///   - includeSeries: Whether to attach series details to each episode.
	///   - includeEpisodeFile: Whether to attach episode file details to each episode.
	///   - includeEpisodeImages: Whether to attach artwork to each episode.
	///   - tags: Restricts results to episodes of series with any of the given tags.
	static func calendar(
		start: Date? = nil,
		end: Date? = nil,
		unmonitored: Bool = false,
		includeSeries: Bool = false,
		includeEpisodeFile: Bool = false,
		includeEpisodeImages: Bool = false,
		tags: [Int] = []
	) -> SonarrRequest<[EpisodeResource]> {
		var queryItems: [URLQueryItem] = [
			URLQueryItem(name: "unmonitored", value: String(unmonitored)),
			URLQueryItem(name: "includeSeries", value: String(includeSeries)),
			URLQueryItem(name: "includeEpisodeFile", value: String(includeEpisodeFile)),
			URLQueryItem(name: "includeEpisodeImages", value: String(includeEpisodeImages)),
		]

		if let start {
			queryItems.append(URLQueryItem(name: "start", value: ISO8601DateFormatter().string(from: start)))
		}

		if let end {
			queryItems.append(URLQueryItem(name: "end", value: ISO8601DateFormatter().string(from: end)))
		}

		if !tags.isEmpty {
			queryItems.append(URLQueryItem(name: "tags", value: tags.map(String.init).joined(separator: ",")))
		}

		return SonarrRequest(method: .get, path: "api/v3/calendar", queryItems: queryItems)
	}
}

public extension SonarrRequest where SonarrResponse == EpisodeResource {
	/// Gets a single calendar entry.
	///
	/// Endpoint: `GET /api/v3/calendar/{id}`
	///
	/// Result: the requested episode.
	///
	/// - Parameter id: The unique identifier of the episode.
	static func calendarEntry(id: Int) -> SonarrRequest<EpisodeResource> {
		SonarrRequest(method: .get, path: "api/v3/calendar/\(id)")
	}
}
