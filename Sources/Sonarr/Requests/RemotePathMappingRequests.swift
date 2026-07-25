import APIClient
import Foundation

public extension SonarrRequest where SonarrResponse == [RemotePathMappingResource] {
	/// Gets all saved remote path mappings.
	///
	/// Endpoint: `GET /api/v3/remotepathmapping`
	///
	/// Result: the saved remote path mappings.
	static var remotePathMappings: SonarrRequest<[RemotePathMappingResource]> {
		SonarrRequest(method: .get, path: "api/v3/remotepathmapping")
	}
}

public extension SonarrRequest where SonarrResponse == RemotePathMappingResource {
	/// Creates a new remote path mapping.
	///
	/// Endpoint: `POST /api/v3/remotepathmapping`
	///
	/// Result: the created remote path mapping.
	///
	/// - Parameter remotePathMapping: The remote path mapping to create.
	static func addRemotePathMapping(
		_ remotePathMapping: RemotePathMappingResource
	) -> SonarrRequest<RemotePathMappingResource> {
		SonarrRequest(method: .post, path: "api/v3/remotepathmapping", body: { JSONBody(remotePathMapping) })
	}

	/// Updates an existing remote path mapping.
	///
	/// Endpoint: `PUT /api/v3/remotepathmapping/{id}`
	///
	/// Result: the updated remote path mapping.
	///
	/// - Parameters:
	///   - id: The unique identifier of the remote path mapping to update.
	///   - remotePathMapping: The new remote path mapping.
	static func updateRemotePathMapping(
		id: Int,
		_ remotePathMapping: RemotePathMappingResource
	) -> SonarrRequest<RemotePathMappingResource> {
		SonarrRequest(method: .put, path: "api/v3/remotepathmapping/\(id)", body: { JSONBody(remotePathMapping) })
	}

	/// Gets a single remote path mapping.
	///
	/// Endpoint: `GET /api/v3/remotepathmapping/{id}`
	///
	/// Result: the requested remote path mapping.
	///
	/// - Parameter id: The unique identifier of the remote path mapping.
	static func remotePathMapping(id: Int) -> SonarrRequest<RemotePathMappingResource> {
		SonarrRequest(method: .get, path: "api/v3/remotepathmapping/\(id)")
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Deletes a remote path mapping.
	///
	/// Endpoint: `DELETE /api/v3/remotepathmapping/{id}`
	///
	/// - Parameter id: The unique identifier of the remote path mapping to delete.
	static func deleteRemotePathMapping(id: Int) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .delete, path: "api/v3/remotepathmapping/\(id)")
	}
}
