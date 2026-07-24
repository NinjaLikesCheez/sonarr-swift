import APIClient
import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public extension SonarrRequest where SonarrResponse == ImportListConfigResource {
	/// Gets the global import list configuration.
	///
	/// Endpoint: `GET /api/v3/config/importlist`
	///
	/// Result: the current import list configuration.
	static var importListConfig: SonarrRequest<ImportListConfigResource> {
		SonarrRequest(method: .get, path: "api/v3/config/importlist")
	}

	/// Gets the global import list configuration by ID.
	///
	/// Endpoint: `GET /api/v3/config/importlist/{id}`
	///
	/// Result: the requested import list configuration.
	///
	/// - Parameter id: The unique identifier of the import list configuration.
	static func importListConfig(id: Int) -> SonarrRequest<ImportListConfigResource> {
		SonarrRequest(method: .get, path: "api/v3/config/importlist/\(id)")
	}

	/// Updates the global import list configuration.
	///
	/// Endpoint: `PUT /api/v3/config/importlist/{id}`
	///
	/// Result: the updated import list configuration.
	///
	/// - Parameters:
	///   - id: The unique identifier of the import list configuration.
	///   - importListConfig: The new import list configuration.
	static func updateImportListConfig(
		id: Int,
		_ importListConfig: ImportListConfigResource
	) -> SonarrRequest<ImportListConfigResource> {
		SonarrRequest(
			method: .put,
			path: "api/v3/config/importlist/\(id)",
			body: { JSONBody(importListConfig) }
		)
	}
}
