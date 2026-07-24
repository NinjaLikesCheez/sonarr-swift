import APIClient
import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public extension SonarrRequest where SonarrResponse == [IndexerResource] {
	/// Gets all configured indexers.
	///
	/// Endpoint: `GET /api/v3/indexer`
	///
	/// Result: the saved indexers.
	static var indexers: SonarrRequest<[IndexerResource]> {
		SonarrRequest(method: .get, path: "api/v3/indexer")
	}

	/// Gets the available indexer implementations and their configurable fields.
	///
	/// Endpoint: `GET /api/v3/indexer/schema`
	///
	/// Result: the implementation templates that can be used to add an indexer.
	static var indexerSchema: SonarrRequest<[IndexerResource]> {
		SonarrRequest(method: .get, path: "api/v3/indexer/schema")
	}

	// The OpenAPI spec documents this endpoint's response as a single IndexerResource, but the server actually
	// returns an array of the updated indexers (matching ImportList's equivalent bulk endpoint) - see
	// https://github.com/NinjaLikesCheez/sonarr-swift/pull/92.
	/// Updates tags, priority, or enablement for multiple indexers in a single request.
	///
	/// Endpoint: `PUT /api/v3/indexer/bulk`
	///
	/// Result: the updated indexers.
	///
	/// - Parameter bulkResource: The identifiers and fields to update across the affected indexers.
	static func updateIndexers(_ bulkResource: IndexerBulkResource) -> SonarrRequest<[IndexerResource]> {
		SonarrRequest(method: .put, path: "api/v3/indexer/bulk", body: { JSONBody(bulkResource) })
	}
}

public extension SonarrRequest where SonarrResponse == IndexerResource {
	/// Gets a single indexer.
	///
	/// Endpoint: `GET /api/v3/indexer/{id}`
	///
	/// Result: the requested indexer.
	///
	/// - Parameter id: The unique identifier of the indexer.
	static func indexer(id: Int) -> SonarrRequest<IndexerResource> {
		SonarrRequest(method: .get, path: "api/v3/indexer/\(id)")
	}

	/// Creates a new indexer.
	///
	/// Endpoint: `POST /api/v3/indexer`
	///
	/// Result: the created indexer.
	///
	/// - Parameters:
	///   - indexer: The indexer to create.
	///   - forceSave: Whether to save the indexer even if Sonarr can't connect to it.
	static func addIndexer(
		_ indexer: IndexerResource,
		forceSave: Bool = false
	) -> SonarrRequest<IndexerResource> {
		SonarrRequest(
			method: .post,
			path: "api/v3/indexer",
			queryItems: [URLQueryItem(name: "forceSave", value: String(forceSave))],
			body: { JSONBody(indexer) }
		)
	}

	/// Updates an existing indexer.
	///
	/// Endpoint: `PUT /api/v3/indexer/{id}`
	///
	/// Result: the updated indexer.
	///
	/// - Parameters:
	///   - id: The unique identifier of the indexer to update.
	///   - indexer: The new indexer.
	///   - forceSave: Whether to save the indexer even if Sonarr can't connect to it.
	static func updateIndexer(
		id: Int,
		_ indexer: IndexerResource,
		forceSave: Bool = false
	) -> SonarrRequest<IndexerResource> {
		SonarrRequest(
			method: .put,
			path: "api/v3/indexer/\(id)",
			queryItems: [URLQueryItem(name: "forceSave", value: String(forceSave))],
			body: { JSONBody(indexer) }
		)
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Deletes an indexer.
	///
	/// Endpoint: `DELETE /api/v3/indexer/{id}`
	///
	/// - Parameter id: The unique identifier of the indexer to delete.
	static func deleteIndexer(id: Int) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .delete, path: "api/v3/indexer/\(id)")
	}

	/// Deletes multiple indexers in a single request.
	///
	/// Endpoint: `DELETE /api/v3/indexer/bulk`
	///
	/// - Parameter bulkResource: The identifiers of the indexers to delete.
	static func deleteIndexers(_ bulkResource: IndexerBulkResource) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .delete, path: "api/v3/indexer/bulk", body: { JSONBody(bulkResource) })
	}

	/// Tests the connection for an indexer configuration without saving it.
	///
	/// Endpoint: `POST /api/v3/indexer/test`
	///
	/// - Parameters:
	///   - indexer: The indexer configuration to test.
	///   - forceTest: Whether to run the test even if Sonarr would normally skip it.
	static func testIndexer(
		_ indexer: IndexerResource,
		forceTest: Bool = false
	) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(
			method: .post,
			path: "api/v3/indexer/test",
			queryItems: [URLQueryItem(name: "forceTest", value: String(forceTest))],
			body: { JSONBody(indexer) }
		)
	}

	/// Tests the connection for all configured indexers.
	///
	/// Endpoint: `POST /api/v3/indexer/testall`
	static var testAllIndexers: SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .post, path: "api/v3/indexer/testall")
	}

	/// Performs an implementation-defined action for an indexer (e.g. a "get categories" button).
	///
	/// Endpoint: `POST /api/v3/indexer/action/{name}`
	///
	/// - Parameters:
	///   - name: The name of the action to perform.
	///   - indexer: The indexer configuration the action is performed against.
	static func performIndexerAction(
		name: String,
		_ indexer: IndexerResource
	) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(
			method: .post,
			path: "api/v3/indexer/action/\(name)",
			body: { JSONBody(indexer) }
		)
	}
}
