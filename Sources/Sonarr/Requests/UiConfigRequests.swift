import APIClient
import Foundation

public extension SonarrRequest where SonarrResponse == UiConfigResource {
	/// Gets the UI configuration.
	///
	/// Endpoint: `GET /api/v3/config/ui`
	///
	/// Result: the current UI configuration.
	static var uiConfig: SonarrRequest<UiConfigResource> {
		SonarrRequest(method: .get, path: "api/v3/config/ui")
	}

	/// Gets the UI configuration by ID.
	///
	/// Endpoint: `GET /api/v3/config/ui/{id}`
	///
	/// Result: the requested UI configuration.
	///
	/// - Parameter id: The unique identifier of the UI configuration.
	static func uiConfig(id: Int) -> SonarrRequest<UiConfigResource> {
		SonarrRequest(method: .get, path: "api/v3/config/ui/\(id)")
	}

	/// Updates the UI configuration.
	///
	/// Endpoint: `PUT /api/v3/config/ui/{id}`
	///
	/// Result: the updated UI configuration.
	///
	/// - Parameters:
	///   - id: The unique identifier of the UI configuration.
	///   - uiConfig: The new UI configuration.
	static func updateUiConfig(
		id: Int,
		_ uiConfig: UiConfigResource
	) -> SonarrRequest<UiConfigResource> {
		SonarrRequest(method: .put, path: "api/v3/config/ui/\(id)", body: { JSONBody(uiConfig, encoder: sonarrEncoder) })
	}
}
