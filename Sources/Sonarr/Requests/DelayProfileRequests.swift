import APIClient
import Foundation

public extension SonarrRequest where SonarrResponse == [DelayProfileResource] {
	/// Gets all saved delay profiles.
	///
	/// Endpoint: `GET /api/v3/delayprofile`
	///
	/// Result: the saved delay profiles.
	static var delayProfiles: SonarrRequest<[DelayProfileResource]> {
		SonarrRequest(method: .get, path: "api/v3/delayprofile")
	}

	/// Moves a delay profile to a new position in the evaluation order.
	///
	/// Endpoint: `PUT /api/v3/delayprofile/reorder/{id}`
	///
	/// Result: the delay profiles in their new order.
	///
	/// - Parameters:
	///   - id: The unique identifier of the delay profile to move.
	///   - after: The unique identifier of the delay profile it should be placed after, if any.
	static func reorderDelayProfile(id: Int, after: Int? = nil) -> SonarrRequest<[DelayProfileResource]> {
		var queryItems: [URLQueryItem] = []

		if let after {
			queryItems.append(URLQueryItem(name: "after", value: String(after)))
		}

		return SonarrRequest(method: .put, path: "api/v3/delayprofile/reorder/\(id)", queryItems: queryItems)
	}
}

public extension SonarrRequest where SonarrResponse == DelayProfileResource {
	/// Gets a single delay profile.
	///
	/// Endpoint: `GET /api/v3/delayprofile/{id}`
	///
	/// Result: the requested delay profile.
	///
	/// - Parameter id: The unique identifier of the delay profile.
	static func delayProfile(id: Int) -> SonarrRequest<DelayProfileResource> {
		SonarrRequest(method: .get, path: "api/v3/delayprofile/\(id)")
	}

	/// Creates a new delay profile.
	///
	/// Endpoint: `POST /api/v3/delayprofile`
	///
	/// Result: the created delay profile.
	///
	/// - Parameter delayProfile: The delay profile to create.
	static func addDelayProfile(_ delayProfile: DelayProfileResource) -> SonarrRequest<DelayProfileResource> {
		SonarrRequest(method: .post, path: "api/v3/delayprofile", body: { JSONBody(delayProfile) })
	}

	/// Updates an existing delay profile.
	///
	/// Endpoint: `PUT /api/v3/delayprofile/{id}`
	///
	/// Result: the updated delay profile.
	///
	/// - Parameters:
	///   - id: The unique identifier of the delay profile to update.
	///   - delayProfile: The new delay profile.
	static func updateDelayProfile(
		id: Int,
		_ delayProfile: DelayProfileResource
	) -> SonarrRequest<DelayProfileResource> {
		SonarrRequest(method: .put, path: "api/v3/delayprofile/\(id)", body: { JSONBody(delayProfile) })
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Deletes a delay profile.
	///
	/// Endpoint: `DELETE /api/v3/delayprofile/{id}`
	///
	/// - Parameter id: The unique identifier of the delay profile to delete.
	static func deleteDelayProfile(id: Int) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .delete, path: "api/v3/delayprofile/\(id)")
	}
}
