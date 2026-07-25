import APIClient
import Foundation

public extension SonarrRequest where SonarrResponse == [RenameEpisodeResource] {
	/// Gets the episode files Sonarr would rename to match its naming format.
	///
	/// Endpoint: `GET /api/v3/rename`
	///
	/// Result: the pending renames for the given series, optionally restricted to a single season.
	///
	/// - Parameters:
	///   - seriesId: Restricts results to the given series.
	///   - seasonNumber: Restricts results to the given season.
	static func renames(
		seriesId: Int? = nil,
		seasonNumber: Int? = nil
	) -> SonarrRequest<[RenameEpisodeResource]> {
		var queryItems: [URLQueryItem] = []

		if let seriesId {
			queryItems.append(URLQueryItem(name: "seriesId", value: String(seriesId)))
		}

		if let seasonNumber {
			queryItems.append(URLQueryItem(name: "seasonNumber", value: String(seasonNumber)))
		}

		return SonarrRequest(method: .get, path: "api/v3/rename", queryItems: queryItems)
	}
}
