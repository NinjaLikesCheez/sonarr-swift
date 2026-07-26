import APIClient
import Foundation

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Bulk-updates season monitoring across series.
	///
	/// Endpoint: `POST /api/v3/seasonpass`
	///
	/// - Parameter seasonPass: The season monitoring changes to apply.
	static func updateSeasonPass(_ seasonPass: SeasonPassResource) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .post, path: "api/v3/seasonpass", body: { JSONBody(seasonPass, encoder: sonarrEncoder) })
	}
}
