import APIClient
import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public extension SonarrRequest where SonarrResponse == HostConfigResource {
	/// Gets the host configuration.
	///
	/// Endpoint: `GET /api/v3/config/host`
	///
	/// Result: the current host configuration.
	static var hostConfig: SonarrRequest<HostConfigResource> {
		SonarrRequest(method: .get, path: "api/v3/config/host")
	}

	/// Gets the host configuration by ID.
	///
	/// Endpoint: `GET /api/v3/config/host/{id}`
	///
	/// Result: the requested host configuration.
	///
	/// - Parameter id: The unique identifier of the host configuration.
	static func hostConfig(id: Int) -> SonarrRequest<HostConfigResource> {
		SonarrRequest(method: .get, path: "api/v3/config/host/\(id)")
	}

	/// Updates the host configuration.
	///
	/// Endpoint: `PUT /api/v3/config/host/{id}`
	///
	/// Result: the updated host configuration.
	///
	/// - Parameters:
	///   - id: The unique identifier of the host configuration.
	///   - hostConfig: The new host configuration.
	static func updateHostConfig(
		id: Int,
		_ hostConfig: HostConfigResource
	) -> SonarrRequest<HostConfigResource> {
		SonarrRequest(
			method: .put,
			path: "api/v3/config/host/\(id)",
			body: { JSONBody(hostConfig) }
		)
	}
}
