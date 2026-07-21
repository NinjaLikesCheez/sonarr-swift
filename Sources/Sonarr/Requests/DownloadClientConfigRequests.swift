import APIClient
import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public extension SonarrRequest where SonarrResponse == DownloadClientConfigResource {
	/// Gets the global download client configuration.
	///
	/// Endpoint: `GET /api/v3/config/downloadclient`
	///
	/// Result: the current download client configuration.
	static var downloadClientConfig: SonarrRequest<DownloadClientConfigResource> {
		SonarrRequest(method: .get, path: "api/v3/config/downloadclient")
	}

	/// Gets the global download client configuration by ID.
	///
	/// Endpoint: `GET /api/v3/config/downloadclient/{id}`
	///
	/// Result: the requested download client configuration.
	///
	/// - Parameter id: The unique identifier of the download client configuration.
	static func downloadClientConfig(id: Int) -> SonarrRequest<DownloadClientConfigResource> {
		SonarrRequest(method: .get, path: "api/v3/config/downloadclient/\(id)")
	}

	/// Updates the global download client configuration.
	///
	/// Endpoint: `PUT /api/v3/config/downloadclient/{id}`
	///
	/// Result: the updated download client configuration.
	///
	/// - Parameters:
	///   - id: The unique identifier of the download client configuration.
	///   - downloadClientConfig: The new download client configuration.
	static func updateDownloadClientConfig(
		id: Int,
		_ downloadClientConfig: DownloadClientConfigResource
	) -> SonarrRequest<DownloadClientConfigResource> {
		SonarrRequest(
			method: .put,
			path: "api/v3/config/downloadclient/\(id)",
			body: { JSONBody(downloadClientConfig) }
		)
	}
}
