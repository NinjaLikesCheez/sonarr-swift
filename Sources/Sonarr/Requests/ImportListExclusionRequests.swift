import APIClient
import Foundation

public extension SonarrRequest where SonarrResponse == [ImportListExclusionResource] {
	/// Gets all configured import list exclusions.
	///
	/// Endpoint: `GET /api/v3/importlistexclusion`
	///
	/// Result: the saved import list exclusions.
	@available(
		*, deprecated,
		message: "Deprecated by Sonarr in favor of importListExclusions(page:pageSize:sortKey:sortDirection:)"
	)
	static var importListExclusions: SonarrRequest<[ImportListExclusionResource]> {
		SonarrRequest(method: .get, path: "api/v3/importlistexclusion")
	}
}

public extension SonarrRequest where SonarrResponse == PagingResource<ImportListExclusionResource> {
	/// Gets a page of configured import list exclusions.
	///
	/// Endpoint: `GET /api/v3/importlistexclusion/paged`
	///
	/// Result: a page of import list exclusions matching the given filters.
	///
	/// - Parameters:
	///   - page: The page number to fetch, 1-indexed.
	///   - pageSize: The number of records per page.
	///   - sortKey: The field to sort by, e.g. `title`.
	///   - sortDirection: The direction to sort in, e.g. `ascending` or `descending`.
	static func importListExclusions(
		page: Int? = nil,
		pageSize: Int? = nil,
		sortKey: String? = nil,
		sortDirection: String? = nil
	) -> SonarrRequest<PagingResource<ImportListExclusionResource>> {
		var queryItems: [URLQueryItem] = []

		if let page {
			queryItems.append(URLQueryItem(name: "page", value: String(page)))
		}

		if let pageSize {
			queryItems.append(URLQueryItem(name: "pageSize", value: String(pageSize)))
		}

		if let sortKey {
			queryItems.append(URLQueryItem(name: "sortKey", value: sortKey))
		}

		if let sortDirection {
			queryItems.append(URLQueryItem(name: "sortDirection", value: sortDirection))
		}

		return SonarrRequest(method: .get, path: "api/v3/importlistexclusion/paged", queryItems: queryItems)
	}
}

public extension SonarrRequest where SonarrResponse == ImportListExclusionResource {
	/// Gets a single import list exclusion.
	///
	/// Endpoint: `GET /api/v3/importlistexclusion/{id}`
	///
	/// Result: the requested import list exclusion.
	///
	/// - Parameter id: The unique identifier of the import list exclusion.
	static func importListExclusion(id: Int) -> SonarrRequest<ImportListExclusionResource> {
		SonarrRequest(method: .get, path: "api/v3/importlistexclusion/\(id)")
	}

	/// Creates a new import list exclusion.
	///
	/// Endpoint: `POST /api/v3/importlistexclusion`
	///
	/// Result: the created import list exclusion.
	///
	/// - Parameter exclusion: The import list exclusion to create.
	static func addImportListExclusion(
		_ exclusion: ImportListExclusionResource
	) -> SonarrRequest<ImportListExclusionResource> {
		SonarrRequest(
			method: .post, path: "api/v3/importlistexclusion", body: { JSONBody(exclusion, encoder: sonarrEncoder) })
	}

	/// Updates an existing import list exclusion.
	///
	/// Endpoint: `PUT /api/v3/importlistexclusion/{id}`
	///
	/// Result: the updated import list exclusion.
	///
	/// - Parameters:
	///   - id: The unique identifier of the import list exclusion to update.
	///   - exclusion: The new import list exclusion.
	static func updateImportListExclusion(
		id: Int,
		_ exclusion: ImportListExclusionResource
	) -> SonarrRequest<ImportListExclusionResource> {
		SonarrRequest(
			method: .put, path: "api/v3/importlistexclusion/\(id)", body: { JSONBody(exclusion, encoder: sonarrEncoder) })
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Deletes an import list exclusion.
	///
	/// Endpoint: `DELETE /api/v3/importlistexclusion/{id}`
	///
	/// - Parameter id: The unique identifier of the import list exclusion to delete.
	static func deleteImportListExclusion(id: Int) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .delete, path: "api/v3/importlistexclusion/\(id)")
	}

	/// Deletes multiple import list exclusions in a single request.
	///
	/// Endpoint: `DELETE /api/v3/importlistexclusion/bulk`
	///
	/// - Parameter bulkResource: The identifiers of the import list exclusions to delete.
	static func deleteImportListExclusions(
		_ bulkResource: ImportListExclusionBulkResource
	) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(
			method: .delete, path: "api/v3/importlistexclusion/bulk", body: { JSONBody(bulkResource, encoder: sonarrEncoder) }
		)
	}
}
