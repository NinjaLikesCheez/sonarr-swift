import APIClient
import Foundation

public extension SonarrRequest where SonarrResponse == [UpdateResource] {
	/// Gets the available and installed updates for this Sonarr instance.
	///
	/// Endpoint: `GET /api/v3/update`
	///
	/// Result: the update history and available releases.
	static var updates: SonarrRequest<[UpdateResource]> {
		SonarrRequest(method: .get, path: "api/v3/update")
	}
}
