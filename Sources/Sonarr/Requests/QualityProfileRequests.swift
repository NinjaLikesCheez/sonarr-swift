import APIClient
import Foundation

public extension SonarrRequest where SonarrResponse == [QualityProfileResource] {
	/// Gets all configured quality profiles.
	///
	/// Endpoint: `GET /api/v3/qualityprofile`
	///
	/// Result: the saved quality profiles.
	static var qualityProfiles: SonarrRequest<[QualityProfileResource]> {
		SonarrRequest(method: .get, path: "api/v3/qualityprofile")
	}
}

public extension SonarrRequest where SonarrResponse == QualityProfileResource {
	/// Creates a new quality profile.
	///
	/// Endpoint: `POST /api/v3/qualityprofile`
	///
	/// Result: the created quality profile.
	///
	/// - Parameter qualityProfile: The quality profile to create.
	static func addQualityProfile(_ qualityProfile: QualityProfileResource) -> SonarrRequest<QualityProfileResource> {
		SonarrRequest(
			method: .post, path: "api/v3/qualityprofile", body: { JSONBody(qualityProfile, encoder: sonarrEncoder) })
	}

	/// Updates an existing quality profile.
	///
	/// Endpoint: `PUT /api/v3/qualityprofile/{id}`
	///
	/// Result: the updated quality profile.
	///
	/// - Parameters:
	///   - id: The unique identifier of the quality profile to update.
	///   - qualityProfile: The new quality profile.
	static func updateQualityProfile(
		id: Int,
		_ qualityProfile: QualityProfileResource
	) -> SonarrRequest<QualityProfileResource> {
		SonarrRequest(
			method: .put, path: "api/v3/qualityprofile/\(id)", body: { JSONBody(qualityProfile, encoder: sonarrEncoder) })
	}

	/// Gets a single quality profile.
	///
	/// Endpoint: `GET /api/v3/qualityprofile/{id}`
	///
	/// Result: the requested quality profile.
	///
	/// - Parameter id: The unique identifier of the quality profile.
	static func qualityProfile(id: Int) -> SonarrRequest<QualityProfileResource> {
		SonarrRequest(method: .get, path: "api/v3/qualityprofile/\(id)")
	}

	/// Gets the default schema for a new quality profile.
	///
	/// Endpoint: `GET /api/v3/qualityprofile/schema`
	///
	/// Result: a quality profile template with the full set of qualities, ready to be customized and created.
	static var qualityProfileSchema: SonarrRequest<QualityProfileResource> {
		SonarrRequest(method: .get, path: "api/v3/qualityprofile/schema")
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Deletes a quality profile.
	///
	/// Endpoint: `DELETE /api/v3/qualityprofile/{id}`
	///
	/// - Parameter id: The unique identifier of the quality profile to delete.
	static func deleteQualityProfile(id: Int) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .delete, path: "api/v3/qualityprofile/\(id)")
	}
}
