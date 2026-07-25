import APIClient
import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public extension SonarrRequest where SonarrResponse == [QualityDefinitionResource] {
	/// Gets all quality definitions.
	///
	/// Endpoint: `GET /api/v3/qualitydefinition`
	///
	/// Result: the saved quality definitions.
	static var qualityDefinitions: SonarrRequest<[QualityDefinitionResource]> {
		SonarrRequest(method: .get, path: "api/v3/qualitydefinition")
	}

	/// Updates multiple quality definitions in a single request.
	///
	/// Endpoint: `PUT /api/v3/qualitydefinition/update`
	///
	/// Result: the updated quality definitions.
	///
	/// - Parameter qualityDefinitions: The quality definitions to update.
	static func updateQualityDefinitions(
		_ qualityDefinitions: [QualityDefinitionResource]
	) -> SonarrRequest<[QualityDefinitionResource]> {
		SonarrRequest(method: .put, path: "api/v3/qualitydefinition/update", body: { JSONBody(qualityDefinitions) })
	}
}

public extension SonarrRequest where SonarrResponse == QualityDefinitionResource {
	/// Gets a single quality definition.
	///
	/// Endpoint: `GET /api/v3/qualitydefinition/{id}`
	///
	/// Result: the requested quality definition.
	///
	/// - Parameter id: The unique identifier of the quality definition.
	static func qualityDefinition(id: Int) -> SonarrRequest<QualityDefinitionResource> {
		SonarrRequest(method: .get, path: "api/v3/qualitydefinition/\(id)")
	}

	/// Updates an existing quality definition.
	///
	/// Endpoint: `PUT /api/v3/qualitydefinition/{id}`
	///
	/// Result: the updated quality definition.
	///
	/// - Parameters:
	///   - id: The unique identifier of the quality definition to update.
	///   - qualityDefinition: The new quality definition.
	static func updateQualityDefinition(
		id: Int,
		_ qualityDefinition: QualityDefinitionResource
	) -> SonarrRequest<QualityDefinitionResource> {
		SonarrRequest(method: .put, path: "api/v3/qualitydefinition/\(id)", body: { JSONBody(qualityDefinition) })
	}
}

public extension SonarrRequest where SonarrResponse == QualityDefinitionLimitsResource {
	/// Gets the minimum and maximum size limits allowed across all quality definitions.
	///
	/// Endpoint: `GET /api/v3/qualitydefinition/limits`
	///
	/// Result: the allowed size limits.
	static var qualityDefinitionLimits: SonarrRequest<QualityDefinitionLimitsResource> {
		SonarrRequest(method: .get, path: "api/v3/qualitydefinition/limits")
	}
}
