import APIClient
import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public extension SonarrRequest where SonarrResponse == IndexerConfigResource {
	/// Gets the global indexer configuration.
	///
	/// Endpoint: `GET /api/v3/config/indexer`
	///
	/// Result: the current indexer configuration.
	static var indexerConfig: SonarrRequest<IndexerConfigResource> {
		SonarrRequest(method: .get, path: "api/v3/config/indexer")
	}

	/// Gets the global indexer configuration by ID.
	///
	/// Endpoint: `GET /api/v3/config/indexer/{id}`
	///
	/// Result: the requested indexer configuration.
	///
	/// - Parameter id: The unique identifier of the indexer configuration.
	static func indexerConfig(id: Int) -> SonarrRequest<IndexerConfigResource> {
		SonarrRequest(method: .get, path: "api/v3/config/indexer/\(id)")
	}

	/// Updates the global indexer configuration.
	///
	/// Endpoint: `PUT /api/v3/config/indexer/{id}`
	///
	/// Result: the updated indexer configuration.
	///
	/// - Parameters:
	///   - id: The unique identifier of the indexer configuration.
	///   - indexerConfig: The new indexer configuration.
	static func updateIndexerConfig(
		id: Int,
		_ indexerConfig: IndexerConfigResource
	) -> SonarrRequest<IndexerConfigResource> {
		SonarrRequest(
			method: .put,
			path: "api/v3/config/indexer/\(id)",
			body: { JSONBody(indexerConfig) }
		)
	}
}
