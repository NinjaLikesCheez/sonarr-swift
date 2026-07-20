import APIClient

public extension SonarrRequest where SonarrResponse == [AutoTaggingResource] {
	/// Gets all auto-tagging definitions.
	///
	/// Endpoint: `GET /api/v3/autotagging`
	///
	/// Result: the saved auto-tagging definitions.
	static var autoTaggings: SonarrRequest<[AutoTaggingResource]> {
		SonarrRequest(method: .get, path: "api/v3/autotagging")
	}
}

public extension SonarrRequest where SonarrResponse == AutoTaggingResource {
	/// Gets a single auto-tagging definition.
	///
	/// Endpoint: `GET /api/v3/autotagging/{id}`
	///
	/// Result: the requested auto-tagging definition.
	///
	/// - Parameter id: The unique identifier of the auto-tag.
	static func autoTagging(id: Int) -> SonarrRequest<AutoTaggingResource> {
		SonarrRequest(method: .get, path: "api/v3/autotagging/\(id)")
	}

	/// Creates a new auto-tagging definition.
	///
	/// Endpoint: `POST /api/v3/autotagging`
	///
	/// Result: the created auto-tagging definition.
	///
	/// - Parameter autoTagging: The auto-tagging definition to create.
	static func addAutoTagging(_ autoTagging: AutoTaggingResource) -> SonarrRequest<AutoTaggingResource> {
		SonarrRequest(method: .post, path: "api/v3/autotagging", body: { JSONBody(autoTagging) })
	}

	/// Updates an existing auto-tagging definition.
	///
	/// Endpoint: `PUT /api/v3/autotagging/{id}`
	///
	/// Result: the updated auto-tagging definition.
	///
	/// - Parameters:
	///   - id: The unique identifier of the auto-tag to update.
	///   - autoTagging: The new auto-tagging definition.
	static func updateAutoTagging(id: Int, _ autoTagging: AutoTaggingResource) -> SonarrRequest<AutoTaggingResource> {
		SonarrRequest(method: .put, path: "api/v3/autotagging/\(id)", body: { JSONBody(autoTagging) })
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Deletes an auto-tagging definition.
	///
	/// Endpoint: `DELETE /api/v3/autotagging/{id}`
	///
	/// - Parameter id: The unique identifier of the auto-tag to delete.
	static func deleteAutoTagging(id: Int) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .delete, path: "api/v3/autotagging/\(id)")
	}
}

public extension SonarrRequest where SonarrResponse == [AutoTaggingSpecificationSchema] {
	/// Gets the available auto-tagging condition templates and their configurable fields.
	///
	/// Endpoint: `GET /api/v3/autotagging/schema`
	///
	/// Result: the condition templates that can be used to build an auto-tagging definition.
	static var autoTaggingSchema: SonarrRequest<[AutoTaggingSpecificationSchema]> {
		SonarrRequest(method: .get, path: "api/v3/autotagging/schema")
	}
}
