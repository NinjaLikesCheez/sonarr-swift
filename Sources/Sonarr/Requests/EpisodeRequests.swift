import APIClient
import Foundation

public extension SonarrRequest where SonarrResponse == [EpisodeResource] {
	/// Gets episodes, optionally filtered by series, season, or episode/file identifiers.
	///
	/// Endpoint: `GET /api/v3/episode`
	///
	/// Result: the episodes matching the given filters.
	///
	/// - Parameters:
	///   - seriesId: Restricts results to episodes of the given series.
	///   - seasonNumber: Restricts results to episodes of the given season.
	///   - episodeIds: Restricts results to the given episode identifiers.
	///   - episodeFileId: Restricts results to episodes associated with the given episode file.
	///   - includeSeries: Whether to attach series details to each episode.
	///   - includeEpisodeFile: Whether to attach episode file details to each episode.
	///   - includeImages: Whether to attach artwork to each episode.
	static func episodes(
		seriesId: Int? = nil,
		seasonNumber: Int? = nil,
		episodeIds: [Int] = [],
		episodeFileId: Int? = nil,
		includeSeries: Bool = false,
		includeEpisodeFile: Bool = false,
		includeImages: Bool = false
	) -> SonarrRequest<[EpisodeResource]> {
		var queryItems: [URLQueryItem] = [
			URLQueryItem(name: "includeSeries", value: String(includeSeries)),
			URLQueryItem(name: "includeEpisodeFile", value: String(includeEpisodeFile)),
			URLQueryItem(name: "includeImages", value: String(includeImages)),
		]

		if let seriesId {
			queryItems.append(URLQueryItem(name: "seriesId", value: String(seriesId)))
		}

		if let seasonNumber {
			queryItems.append(URLQueryItem(name: "seasonNumber", value: String(seasonNumber)))
		}

		for episodeId in episodeIds {
			queryItems.append(URLQueryItem(name: "episodeIds", value: String(episodeId)))
		}

		if let episodeFileId {
			queryItems.append(URLQueryItem(name: "episodeFileId", value: String(episodeFileId)))
		}

		return SonarrRequest(method: .get, path: "api/v3/episode", queryItems: queryItems)
	}

}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Updates the monitored state of multiple episodes in a single request.
	///
	/// Endpoint: `PUT /api/v3/episode/monitor`
	///
	/// - Parameters:
	///   - episodesMonitored: The episode identifiers and monitored state to apply.
	///   - includeImages: Whether to attach artwork to each episode.
	static func updateEpisodesMonitored(
		_ episodesMonitored: EpisodesMonitoredResource,
		includeImages: Bool = false
	) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(
			method: .put,
			path: "api/v3/episode/monitor",
			queryItems: [URLQueryItem(name: "includeImages", value: String(includeImages))],
			body: { JSONBody(episodesMonitored) }
		)
	}
}

public extension SonarrRequest where SonarrResponse == EpisodeResource {
	/// Gets a single episode.
	///
	/// Endpoint: `GET /api/v3/episode/{id}`
	///
	/// Result: the requested episode.
	///
	/// - Parameter id: The unique identifier of the episode.
	static func episode(id: Int) -> SonarrRequest<EpisodeResource> {
		SonarrRequest(method: .get, path: "api/v3/episode/\(id)")
	}

	/// Updates an existing episode.
	///
	/// Endpoint: `PUT /api/v3/episode/{id}`
	///
	/// Result: the updated episode.
	///
	/// - Parameters:
	///   - id: The unique identifier of the episode to update.
	///   - episode: The new episode.
	static func updateEpisode(id: Int, _ episode: EpisodeResource) -> SonarrRequest<EpisodeResource> {
		SonarrRequest(method: .put, path: "api/v3/episode/\(id)", body: { JSONBody(episode) })
	}
}
