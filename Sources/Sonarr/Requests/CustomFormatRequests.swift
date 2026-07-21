import APIClient

public extension SonarrRequest where SonarrResponse == [CustomFormatResource] {
	/// Gets all saved custom formats.
	///
	/// Endpoint: `GET /api/v3/customformat`
	///
	/// Result: the saved custom formats.
	static var customFormats: SonarrRequest<[CustomFormatResource]> {
		SonarrRequest(method: .get, path: "api/v3/customformat")
	}

	/// Updates the rename inclusion setting for multiple custom formats in a single request.
	///
	/// Endpoint: `PUT /api/v3/customformat/bulk`
	///
	/// Result: the updated custom formats.
	///
	/// - Parameters:
	///   - ids: The identifiers of the custom formats to update.
	///   - includeCustomFormatWhenRenaming: Whether the affected custom formats' names are appended to the file
	///   when renaming.
	static func updateCustomFormats(
		ids: [Int],
		includeCustomFormatWhenRenaming: Bool? = nil
	) -> SonarrRequest<[CustomFormatResource]> {
		SonarrRequest(
			method: .put,
			path: "api/v3/customformat/bulk",
			body: {
				JSONBody(
					CustomFormatBulkResource(ids: ids, includeCustomFormatWhenRenaming: includeCustomFormatWhenRenaming)
				)
			}
		)
	}
}

public extension SonarrRequest where SonarrResponse == CustomFormatResource {
	/// Gets a single custom format.
	///
	/// Endpoint: `GET /api/v3/customformat/{id}`
	///
	/// Result: the requested custom format.
	///
	/// - Parameter id: The unique identifier of the custom format.
	static func customFormat(id: Int) -> SonarrRequest<CustomFormatResource> {
		SonarrRequest(method: .get, path: "api/v3/customformat/\(id)")
	}

	/// Creates a new custom format.
	///
	/// Endpoint: `POST /api/v3/customformat`
	///
	/// Result: the created custom format.
	///
	/// - Parameter customFormat: The custom format to create.
	static func addCustomFormat(_ customFormat: CustomFormatResource) -> SonarrRequest<CustomFormatResource> {
		SonarrRequest(method: .post, path: "api/v3/customformat", body: { JSONBody(customFormat) })
	}

	/// Updates an existing custom format.
	///
	/// Endpoint: `PUT /api/v3/customformat/{id}`
	///
	/// Result: the updated custom format.
	///
	/// - Parameters:
	///   - id: The unique identifier of the custom format to update.
	///   - customFormat: The new custom format.
	static func updateCustomFormat(
		id: Int,
		_ customFormat: CustomFormatResource
	) -> SonarrRequest<CustomFormatResource> {
		SonarrRequest(method: .put, path: "api/v3/customformat/\(id)", body: { JSONBody(customFormat) })
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Deletes a custom format.
	///
	/// Endpoint: `DELETE /api/v3/customformat/{id}`
	///
	/// - Parameter id: The unique identifier of the custom format to delete.
	static func deleteCustomFormat(id: Int) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .delete, path: "api/v3/customformat/\(id)")
	}

	/// Deletes multiple custom formats in a single request.
	///
	/// Endpoint: `DELETE /api/v3/customformat/bulk`
	///
	/// - Parameter ids: The identifiers of the custom formats to delete.
	static func deleteCustomFormats(ids: [Int]) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(
			method: .delete,
			path: "api/v3/customformat/bulk",
			body: { JSONBody(CustomFormatBulkResource(ids: ids)) }
		)
	}
}

public extension SonarrRequest where SonarrResponse == [CustomFormatSpecificationSchema] {
	/// Gets the available custom format condition templates and their configurable fields.
	///
	/// Endpoint: `GET /api/v3/customformat/schema`
	///
	/// Result: the condition templates that can be used to build a custom format.
	static var customFormatSchema: SonarrRequest<[CustomFormatSpecificationSchema]> {
		SonarrRequest(method: .get, path: "api/v3/customformat/schema")
	}
}
