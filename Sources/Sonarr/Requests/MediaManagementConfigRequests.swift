import APIClient
import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public extension SonarrRequest where SonarrResponse == MediaManagementConfigResource {
	/// Gets the global media management configuration.
	///
	/// Endpoint: `GET /api/v3/config/mediamanagement`
	///
	/// Result: the current media management configuration.
	static var mediaManagementConfig: SonarrRequest<MediaManagementConfigResource> {
		SonarrRequest(method: .get, path: "api/v3/config/mediamanagement")
	}

	/// Gets the global media management configuration by ID.
	///
	/// Endpoint: `GET /api/v3/config/mediamanagement/{id}`
	///
	/// Result: the requested media management configuration.
	///
	/// - Parameter id: The unique identifier of the media management configuration.
	static func mediaManagementConfig(id: Int) -> SonarrRequest<MediaManagementConfigResource> {
		SonarrRequest(method: .get, path: "api/v3/config/mediamanagement/\(id)")
	}

	/// Updates the global media management configuration.
	///
	/// Endpoint: `PUT /api/v3/config/mediamanagement/{id}`
	///
	/// Result: the updated media management configuration.
	///
	/// - Parameters:
	///   - id: The unique identifier of the media management configuration.
	///   - mediaManagementConfig: The new media management configuration.
	static func updateMediaManagementConfig(
		id: Int,
		_ mediaManagementConfig: MediaManagementConfigResource
	) -> SonarrRequest<MediaManagementConfigResource> {
		SonarrRequest(
			method: .put,
			path: "api/v3/config/mediamanagement/\(id)",
			body: { JSONBody(mediaManagementConfig, encoder: sonarrEncoder) }
		)
	}
}
