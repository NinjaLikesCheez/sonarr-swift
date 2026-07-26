import APIClient
import Foundation

public extension SonarrRequest where SonarrResponse == [ReleaseProfileResource] {
	/// Gets all saved release profiles.
	///
	/// Endpoint: `GET /api/v3/releaseprofile`
	///
	/// Result: the saved release profiles.
	static var releaseProfiles: SonarrRequest<[ReleaseProfileResource]> {
		SonarrRequest(method: .get, path: "api/v3/releaseprofile")
	}
}

public extension SonarrRequest where SonarrResponse == ReleaseProfileResource {
	/// Creates a new release profile.
	///
	/// Endpoint: `POST /api/v3/releaseprofile`
	///
	/// Result: the created release profile.
	///
	/// - Parameter releaseProfile: The release profile to create.
	static func addReleaseProfile(_ releaseProfile: ReleaseProfileResource) -> SonarrRequest<ReleaseProfileResource> {
		SonarrRequest(
			method: .post, path: "api/v3/releaseprofile", body: { JSONBody(releaseProfile, encoder: sonarrEncoder) })
	}

	/// Updates an existing release profile.
	///
	/// Endpoint: `PUT /api/v3/releaseprofile/{id}`
	///
	/// Result: the updated release profile.
	///
	/// - Parameters:
	///   - id: The unique identifier of the release profile to update.
	///   - releaseProfile: The new release profile.
	static func updateReleaseProfile(
		id: Int,
		_ releaseProfile: ReleaseProfileResource
	) -> SonarrRequest<ReleaseProfileResource> {
		SonarrRequest(
			method: .put, path: "api/v3/releaseprofile/\(id)", body: { JSONBody(releaseProfile, encoder: sonarrEncoder) })
	}

	/// Gets a single release profile.
	///
	/// Endpoint: `GET /api/v3/releaseprofile/{id}`
	///
	/// Result: the requested release profile.
	///
	/// - Parameter id: The unique identifier of the release profile.
	static func releaseProfile(id: Int) -> SonarrRequest<ReleaseProfileResource> {
		SonarrRequest(method: .get, path: "api/v3/releaseprofile/\(id)")
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Deletes a release profile.
	///
	/// Endpoint: `DELETE /api/v3/releaseprofile/{id}`
	///
	/// - Parameter id: The unique identifier of the release profile to delete.
	static func deleteReleaseProfile(id: Int) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .delete, path: "api/v3/releaseprofile/\(id)")
	}
}
