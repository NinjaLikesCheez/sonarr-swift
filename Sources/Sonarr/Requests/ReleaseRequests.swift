import APIClient
import Foundation

public extension SonarrRequest where SonarrResponse == [ReleaseResource] {
	/// Searches indexers for releases matching a series, episode, or season.
	///
	/// Endpoint: `GET /api/v3/release`
	///
	/// Result: the releases found, along with Sonarr's decision on each.
	///
	/// - Parameters:
	///   - seriesId: Restricts the search to the given series.
	///   - episodeId: Restricts the search to the given episode.
	///   - seasonNumber: Restricts the search to the given season.
	static func releases(
		seriesId: Int? = nil,
		episodeId: Int? = nil,
		seasonNumber: Int? = nil
	) -> SonarrRequest<[ReleaseResource]> {
		var queryItems: [URLQueryItem] = []

		if let seriesId {
			queryItems.append(URLQueryItem(name: "seriesId", value: String(seriesId)))
		}

		if let episodeId {
			queryItems.append(URLQueryItem(name: "episodeId", value: String(episodeId)))
		}

		if let seasonNumber {
			queryItems.append(URLQueryItem(name: "seasonNumber", value: String(seasonNumber)))
		}

		return SonarrRequest(method: .get, path: "api/v3/release", queryItems: queryItems)
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Grabs a release found by a previous search.
	///
	/// Endpoint: `POST /api/v3/release`
	///
	/// - Parameter release: The release to grab, as returned by `releases`.
	static func grabRelease(_ release: ReleaseResource) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .post, path: "api/v3/release", body: { JSONBody(release) })
	}
}
