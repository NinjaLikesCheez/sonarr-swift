import APIClient
import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public extension SonarrRequest where SonarrResponse == [MetadataResource] {
	/// Gets all configured metadata consumers.
	///
	/// Endpoint: `GET /api/v3/metadata`
	///
	/// Result: the saved metadata consumers.
	static var metadataConsumers: SonarrRequest<[MetadataResource]> {
		SonarrRequest(method: .get, path: "api/v3/metadata")
	}

	/// Gets the available metadata consumer implementations and their configurable fields.
	///
	/// Endpoint: `GET /api/v3/metadata/schema`
	///
	/// Result: the implementation templates that can be used to add a metadata consumer.
	static var metadataConsumerSchema: SonarrRequest<[MetadataResource]> {
		SonarrRequest(method: .get, path: "api/v3/metadata/schema")
	}
}

public extension SonarrRequest where SonarrResponse == MetadataResource {
	/// Gets a single metadata consumer.
	///
	/// Endpoint: `GET /api/v3/metadata/{id}`
	///
	/// Result: the requested metadata consumer.
	///
	/// - Parameter id: The unique identifier of the metadata consumer.
	static func metadataConsumer(id: Int) -> SonarrRequest<MetadataResource> {
		SonarrRequest(method: .get, path: "api/v3/metadata/\(id)")
	}

	/// Creates a new metadata consumer.
	///
	/// Endpoint: `POST /api/v3/metadata`
	///
	/// Result: the created metadata consumer.
	///
	/// - Parameters:
	///   - metadataConsumer: The metadata consumer to create.
	///   - forceSave: Whether to save the metadata consumer even if Sonarr can't validate it.
	static func addMetadataConsumer(
		_ metadataConsumer: MetadataResource,
		forceSave: Bool = false
	) -> SonarrRequest<MetadataResource> {
		SonarrRequest(
			method: .post,
			path: "api/v3/metadata",
			queryItems: [URLQueryItem(name: "forceSave", value: String(forceSave))],
			body: { JSONBody(metadataConsumer, encoder: sonarrEncoder) }
		)
	}

	/// Updates an existing metadata consumer.
	///
	/// Endpoint: `PUT /api/v3/metadata/{id}`
	///
	/// Result: the updated metadata consumer.
	///
	/// - Parameters:
	///   - id: The unique identifier of the metadata consumer to update.
	///   - metadataConsumer: The new metadata consumer.
	///   - forceSave: Whether to save the metadata consumer even if Sonarr can't validate it.
	static func updateMetadataConsumer(
		id: Int,
		_ metadataConsumer: MetadataResource,
		forceSave: Bool = false
	) -> SonarrRequest<MetadataResource> {
		SonarrRequest(
			method: .put,
			path: "api/v3/metadata/\(id)",
			queryItems: [URLQueryItem(name: "forceSave", value: String(forceSave))],
			body: { JSONBody(metadataConsumer, encoder: sonarrEncoder) }
		)
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Deletes a metadata consumer.
	///
	/// Endpoint: `DELETE /api/v3/metadata/{id}`
	///
	/// - Parameter id: The unique identifier of the metadata consumer to delete.
	static func deleteMetadataConsumer(id: Int) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .delete, path: "api/v3/metadata/\(id)")
	}

	/// Tests the configuration for a metadata consumer without saving it.
	///
	/// Endpoint: `POST /api/v3/metadata/test`
	///
	/// - Parameters:
	///   - metadataConsumer: The metadata consumer configuration to test.
	///   - forceTest: Whether to run the test even if Sonarr would normally skip it.
	static func testMetadataConsumer(
		_ metadataConsumer: MetadataResource,
		forceTest: Bool = false
	) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(
			method: .post,
			path: "api/v3/metadata/test",
			queryItems: [URLQueryItem(name: "forceTest", value: String(forceTest))],
			body: { JSONBody(metadataConsumer, encoder: sonarrEncoder) }
		)
	}

	/// Tests the configuration for all configured metadata consumers.
	///
	/// Endpoint: `POST /api/v3/metadata/testall`
	static var testAllMetadataConsumers: SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .post, path: "api/v3/metadata/testall")
	}

	/// Performs an implementation-defined action for a metadata consumer (e.g. a "check for updates" button).
	///
	/// Endpoint: `POST /api/v3/metadata/action/{name}`
	///
	/// - Parameters:
	///   - name: The name of the action to perform.
	///   - metadataConsumer: The metadata consumer configuration the action is performed against.
	static func performMetadataConsumerAction(
		name: String,
		_ metadataConsumer: MetadataResource
	) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(
			method: .post,
			path: "api/v3/metadata/action/\(name)",
			body: { JSONBody(metadataConsumer, encoder: sonarrEncoder) }
		)
	}
}
