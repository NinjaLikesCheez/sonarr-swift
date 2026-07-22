import APIClient
import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public extension SonarrRequest where SonarrResponse == [ImportListResource] {
	/// Gets all configured import lists.
	///
	/// Endpoint: `GET /api/v3/importlist`
	///
	/// Result: the saved import lists.
	static var importLists: SonarrRequest<[ImportListResource]> {
		SonarrRequest(method: .get, path: "api/v3/importlist")
	}

	/// Gets the available import list implementations and their configurable fields.
	///
	/// Endpoint: `GET /api/v3/importlist/schema`
	///
	/// Result: the implementation templates that can be used to add an import list.
	static var importListSchema: SonarrRequest<[ImportListResource]> {
		SonarrRequest(method: .get, path: "api/v3/importlist/schema")
	}
}

public extension SonarrRequest where SonarrResponse == ImportListResource {
	/// Gets a single import list.
	///
	/// Endpoint: `GET /api/v3/importlist/{id}`
	///
	/// Result: the requested import list.
	///
	/// - Parameter id: The unique identifier of the import list.
	static func importList(id: Int) -> SonarrRequest<ImportListResource> {
		SonarrRequest(method: .get, path: "api/v3/importlist/\(id)")
	}

	/// Creates a new import list.
	///
	/// Endpoint: `POST /api/v3/importlist`
	///
	/// Result: the created import list.
	///
	/// - Parameters:
	///   - importList: The import list to create.
	///   - forceSave: Whether to save the import list even if Sonarr can't connect to it.
	static func addImportList(
		_ importList: ImportListResource,
		forceSave: Bool = false
	) -> SonarrRequest<ImportListResource> {
		SonarrRequest(
			method: .post,
			path: "api/v3/importlist",
			queryItems: [URLQueryItem(name: "forceSave", value: String(forceSave))],
			body: { JSONBody(importList) }
		)
	}

	/// Updates an existing import list.
	///
	/// Endpoint: `PUT /api/v3/importlist/{id}`
	///
	/// Result: the updated import list.
	///
	/// - Parameters:
	///   - id: The unique identifier of the import list to update.
	///   - importList: The new import list.
	///   - forceSave: Whether to save the import list even if Sonarr can't connect to it.
	static func updateImportList(
		id: Int,
		_ importList: ImportListResource,
		forceSave: Bool = false
	) -> SonarrRequest<ImportListResource> {
		SonarrRequest(
			method: .put,
			path: "api/v3/importlist/\(id)",
			queryItems: [URLQueryItem(name: "forceSave", value: String(forceSave))],
			body: { JSONBody(importList) }
		)
	}

	/// Updates tags, automatic add, root folder, or quality profile for multiple import lists in a single request.
	///
	/// Endpoint: `PUT /api/v3/importlist/bulk`
	///
	/// Result: the updated import list.
	///
	/// - Parameter bulkResource: The identifiers and fields to update across the affected import lists.
	static func updateImportLists(_ bulkResource: ImportListBulkResource) -> SonarrRequest<ImportListResource> {
		SonarrRequest(method: .put, path: "api/v3/importlist/bulk", body: { JSONBody(bulkResource) })
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Deletes an import list.
	///
	/// Endpoint: `DELETE /api/v3/importlist/{id}`
	///
	/// - Parameter id: The unique identifier of the import list to delete.
	static func deleteImportList(id: Int) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .delete, path: "api/v3/importlist/\(id)")
	}

	/// Deletes multiple import lists in a single request.
	///
	/// Endpoint: `DELETE /api/v3/importlist/bulk`
	///
	/// - Parameter bulkResource: The identifiers of the import lists to delete.
	static func deleteImportLists(_ bulkResource: ImportListBulkResource) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .delete, path: "api/v3/importlist/bulk", body: { JSONBody(bulkResource) })
	}

	/// Tests the connection for an import list configuration without saving it.
	///
	/// Endpoint: `POST /api/v3/importlist/test`
	///
	/// - Parameters:
	///   - importList: The import list configuration to test.
	///   - forceTest: Whether to run the test even if Sonarr would normally skip it.
	static func testImportList(
		_ importList: ImportListResource,
		forceTest: Bool = false
	) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(
			method: .post,
			path: "api/v3/importlist/test",
			queryItems: [URLQueryItem(name: "forceTest", value: String(forceTest))],
			body: { JSONBody(importList) }
		)
	}

	/// Tests the connection for all configured import lists.
	///
	/// Endpoint: `POST /api/v3/importlist/testall`
	static var testAllImportLists: SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .post, path: "api/v3/importlist/testall")
	}

	/// Performs an implementation-defined action for an import list (e.g. a "fetch lists" button).
	///
	/// Endpoint: `POST /api/v3/importlist/action/{name}`
	///
	/// - Parameters:
	///   - name: The name of the action to perform.
	///   - importList: The import list configuration the action is performed against.
	static func performImportListAction(
		name: String,
		_ importList: ImportListResource
	) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(
			method: .post,
			path: "api/v3/importlist/action/\(name)",
			body: { JSONBody(importList) }
		)
	}
}
