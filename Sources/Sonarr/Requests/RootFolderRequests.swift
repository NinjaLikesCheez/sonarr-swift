import APIClient
import Foundation

public extension SonarrRequest where SonarrResponse == [RootFolderResource] {
	/// Gets all saved root folders.
	///
	/// Endpoint: `GET /api/v3/rootfolder`
	///
	/// Result: the saved root folders.
	static var rootFolders: SonarrRequest<[RootFolderResource]> {
		SonarrRequest(method: .get, path: "api/v3/rootfolder")
	}
}

public extension SonarrRequest where SonarrResponse == RootFolderResource {
	/// Creates a new root folder.
	///
	/// Endpoint: `POST /api/v3/rootfolder`
	///
	/// Result: the created root folder.
	///
	/// - Parameter rootFolder: The root folder to create.
	static func addRootFolder(_ rootFolder: RootFolderResource) -> SonarrRequest<RootFolderResource> {
		SonarrRequest(method: .post, path: "api/v3/rootfolder", body: { JSONBody(rootFolder, encoder: sonarrEncoder) })
	}

	/// Gets a single root folder.
	///
	/// Endpoint: `GET /api/v3/rootfolder/{id}`
	///
	/// Result: the requested root folder.
	///
	/// - Parameter id: The unique identifier of the root folder.
	static func rootFolder(id: Int) -> SonarrRequest<RootFolderResource> {
		SonarrRequest(method: .get, path: "api/v3/rootfolder/\(id)")
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Deletes a root folder.
	///
	/// Endpoint: `DELETE /api/v3/rootfolder/{id}`
	///
	/// - Parameter id: The unique identifier of the root folder to delete.
	static func deleteRootFolder(id: Int) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .delete, path: "api/v3/rootfolder/\(id)")
	}
}
