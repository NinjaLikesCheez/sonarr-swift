import APIClient
import Foundation

public extension SonarrRequest where SonarrResponse == [TagResource] {
	/// Gets all saved tags.
	///
	/// Endpoint: `GET /api/v3/tag`
	///
	/// Result: the saved tags.
	static var tags: SonarrRequest<[TagResource]> {
		SonarrRequest(method: .get, path: "api/v3/tag")
	}
}

public extension SonarrRequest where SonarrResponse == [TagDetailsResource] {
	/// Gets all saved tags, along with the identifiers of every resource each is attached to.
	///
	/// Endpoint: `GET /api/v3/tag/detail`
	///
	/// Result: the saved tags with their usage details.
	static var tagDetails: SonarrRequest<[TagDetailsResource]> {
		SonarrRequest(method: .get, path: "api/v3/tag/detail")
	}
}

public extension SonarrRequest where SonarrResponse == TagResource {
	/// Creates a new tag.
	///
	/// Endpoint: `POST /api/v3/tag`
	///
	/// Result: the created tag.
	///
	/// - Parameter tag: The tag to create.
	static func addTag(_ tag: TagResource) -> SonarrRequest<TagResource> {
		SonarrRequest(method: .post, path: "api/v3/tag", body: { JSONBody(tag) })
	}

	/// Updates an existing tag.
	///
	/// Endpoint: `PUT /api/v3/tag/{id}`
	///
	/// Result: the updated tag.
	///
	/// - Parameters:
	///   - id: The unique identifier of the tag to update.
	///   - tag: The new tag.
	static func updateTag(id: Int, _ tag: TagResource) -> SonarrRequest<TagResource> {
		SonarrRequest(method: .put, path: "api/v3/tag/\(id)", body: { JSONBody(tag) })
	}

	/// Gets a single tag.
	///
	/// Endpoint: `GET /api/v3/tag/{id}`
	///
	/// Result: the requested tag.
	///
	/// - Parameter id: The unique identifier of the tag.
	static func tag(id: Int) -> SonarrRequest<TagResource> {
		SonarrRequest(method: .get, path: "api/v3/tag/\(id)")
	}
}

public extension SonarrRequest where SonarrResponse == TagDetailsResource {
	/// Gets a single tag, along with the identifiers of every resource it's attached to.
	///
	/// Endpoint: `GET /api/v3/tag/detail/{id}`
	///
	/// Result: the requested tag's usage details.
	///
	/// - Parameter id: The unique identifier of the tag.
	static func tagDetails(id: Int) -> SonarrRequest<TagDetailsResource> {
		SonarrRequest(method: .get, path: "api/v3/tag/detail/\(id)")
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Deletes a tag.
	///
	/// Endpoint: `DELETE /api/v3/tag/{id}`
	///
	/// - Parameter id: The unique identifier of the tag to delete.
	static func deleteTag(id: Int) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .delete, path: "api/v3/tag/\(id)")
	}
}
