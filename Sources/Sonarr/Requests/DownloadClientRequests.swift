import APIClient
import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public extension SonarrRequest where SonarrResponse == [DownloadClientResource] {
	/// Gets all configured download clients.
	///
	/// Endpoint: `GET /api/v3/downloadclient`
	///
	/// Result: the saved download clients.
	static var downloadClients: SonarrRequest<[DownloadClientResource]> {
		SonarrRequest(method: .get, path: "api/v3/downloadclient")
	}

	/// Gets the available download client implementations and their configurable fields.
	///
	/// Endpoint: `GET /api/v3/downloadclient/schema`
	///
	/// Result: the implementation templates that can be used to add a download client.
	static var downloadClientSchema: SonarrRequest<[DownloadClientResource]> {
		SonarrRequest(method: .get, path: "api/v3/downloadclient/schema")
	}

	/// Updates tags, priority, or enablement for multiple download clients in a single request.
	///
	/// Endpoint: `PUT /api/v3/downloadclient/bulk`
	///
	/// Result: the updated download clients.
	///
	/// - Parameter bulkResource: The identifiers and fields to update across the affected download clients.
	static func updateDownloadClients(_ bulkResource: DownloadClientBulkResource) -> SonarrRequest<
		[DownloadClientResource]
	> {
		SonarrRequest(method: .put, path: "api/v3/downloadclient/bulk", body: { JSONBody(bulkResource) })
	}
}

public extension SonarrRequest where SonarrResponse == DownloadClientResource {
	/// Gets a single download client.
	///
	/// Endpoint: `GET /api/v3/downloadclient/{id}`
	///
	/// Result: the requested download client.
	///
	/// - Parameter id: The unique identifier of the download client.
	static func downloadClient(id: Int) -> SonarrRequest<DownloadClientResource> {
		SonarrRequest(method: .get, path: "api/v3/downloadclient/\(id)")
	}

	/// Creates a new download client.
	///
	/// Endpoint: `POST /api/v3/downloadclient`
	///
	/// Result: the created download client.
	///
	/// - Parameters:
	///   - downloadClient: The download client to create.
	///   - forceSave: Whether to save the download client even if Sonarr can't connect to it.
	static func addDownloadClient(
		_ downloadClient: DownloadClientResource,
		forceSave: Bool = false
	) -> SonarrRequest<DownloadClientResource> {
		SonarrRequest(
			method: .post,
			path: "api/v3/downloadclient",
			queryItems: [URLQueryItem(name: "forceSave", value: String(forceSave))],
			body: { JSONBody(downloadClient) }
		)
	}

	/// Updates an existing download client.
	///
	/// Endpoint: `PUT /api/v3/downloadclient/{id}`
	///
	/// Result: the updated download client.
	///
	/// - Parameters:
	///   - id: The unique identifier of the download client to update.
	///   - downloadClient: The new download client.
	///   - forceSave: Whether to save the download client even if Sonarr can't connect to it.
	static func updateDownloadClient(
		id: Int,
		_ downloadClient: DownloadClientResource,
		forceSave: Bool = false
	) -> SonarrRequest<DownloadClientResource> {
		SonarrRequest(
			method: .put,
			path: "api/v3/downloadclient/\(id)",
			queryItems: [URLQueryItem(name: "forceSave", value: String(forceSave))],
			body: { JSONBody(downloadClient) }
		)
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Deletes a download client.
	///
	/// Endpoint: `DELETE /api/v3/downloadclient/{id}`
	///
	/// - Parameter id: The unique identifier of the download client to delete.
	static func deleteDownloadClient(id: Int) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .delete, path: "api/v3/downloadclient/\(id)")
	}

	/// Deletes multiple download clients in a single request.
	///
	/// Endpoint: `DELETE /api/v3/downloadclient/bulk`
	///
	/// - Parameter bulkResource: The identifiers of the download clients to delete.
	static func deleteDownloadClients(_ bulkResource: DownloadClientBulkResource) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .delete, path: "api/v3/downloadclient/bulk", body: { JSONBody(bulkResource) })
	}

	/// Tests the connection for a download client configuration without saving it.
	///
	/// Endpoint: `POST /api/v3/downloadclient/test`
	///
	/// - Parameters:
	///   - downloadClient: The download client configuration to test.
	///   - forceTest: Whether to run the test even if Sonarr would normally skip it.
	static func testDownloadClient(
		_ downloadClient: DownloadClientResource,
		forceTest: Bool = false
	) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(
			method: .post,
			path: "api/v3/downloadclient/test",
			queryItems: [URLQueryItem(name: "forceTest", value: String(forceTest))],
			body: { JSONBody(downloadClient) }
		)
	}

	/// Tests the connection for all configured download clients.
	///
	/// Endpoint: `POST /api/v3/downloadclient/testall`
	static var testAllDownloadClients: SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .post, path: "api/v3/downloadclient/testall")
	}

	/// Performs an implementation-defined action for a download client (e.g. a "check for updates" button).
	///
	/// Endpoint: `POST /api/v3/downloadclient/action/{name}`
	///
	/// - Parameters:
	///   - name: The name of the action to perform.
	///   - downloadClient: The download client configuration the action is performed against.
	static func performDownloadClientAction(
		name: String,
		_ downloadClient: DownloadClientResource
	) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(
			method: .post,
			path: "api/v3/downloadclient/action/\(name)",
			body: { JSONBody(downloadClient) }
		)
	}
}
