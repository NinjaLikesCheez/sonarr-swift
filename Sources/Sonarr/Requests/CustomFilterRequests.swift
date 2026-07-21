import APIClient

public extension SonarrRequest where SonarrResponse == [CustomFilterResource] {
	/// Gets all saved custom filters.
	///
	/// Endpoint: `GET /api/v3/customfilter`
	///
	/// Result: the saved custom filters.
	static var customFilters: SonarrRequest<[CustomFilterResource]> {
		SonarrRequest(method: .get, path: "api/v3/customfilter")
	}
}

public extension SonarrRequest where SonarrResponse == CustomFilterResource {
	/// Gets a single custom filter.
	///
	/// Endpoint: `GET /api/v3/customfilter/{id}`
	///
	/// Result: the requested custom filter.
	///
	/// - Parameter id: The unique identifier of the custom filter.
	static func customFilter(id: Int) -> SonarrRequest<CustomFilterResource> {
		SonarrRequest(method: .get, path: "api/v3/customfilter/\(id)")
	}

	/// Creates a new custom filter.
	///
	/// Endpoint: `POST /api/v3/customfilter`
	///
	/// Result: the created custom filter.
	///
	/// - Parameter customFilter: The custom filter to create.
	static func addCustomFilter(_ customFilter: CustomFilterResource) -> SonarrRequest<CustomFilterResource> {
		SonarrRequest(method: .post, path: "api/v3/customfilter", body: { JSONBody(customFilter) })
	}

	/// Updates an existing custom filter.
	///
	/// Endpoint: `PUT /api/v3/customfilter/{id}`
	///
	/// Result: the updated custom filter.
	///
	/// - Parameters:
	///   - id: The unique identifier of the custom filter to update.
	///   - customFilter: The new custom filter.
	static func updateCustomFilter(
		id: Int,
		_ customFilter: CustomFilterResource
	) -> SonarrRequest<CustomFilterResource> {
		SonarrRequest(method: .put, path: "api/v3/customfilter/\(id)", body: { JSONBody(customFilter) })
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Deletes a custom filter.
	///
	/// Endpoint: `DELETE /api/v3/customfilter/{id}`
	///
	/// - Parameter id: The unique identifier of the custom filter to delete.
	static func deleteCustomFilter(id: Int) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .delete, path: "api/v3/customfilter/\(id)")
	}
}
