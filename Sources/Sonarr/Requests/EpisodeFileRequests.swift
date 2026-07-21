import APIClient
import Foundation

// EpisodeFileResource carries a `dateAdded: Date`, which the default JSONEncoder would serialize as a
// numeric timestamp - Sonarr expects ISO 8601 strings on the way in, matching what it sends on the way out.
private let episodeFileEncoder: JSONEncoder = {
	let encoder = JSONEncoder()
	encoder.dateEncodingStrategy = .iso8601
	return encoder
}()

public extension SonarrRequest where SonarrResponse == [EpisodeFileResource] {
	/// Gets episode files, optionally filtered by series or episode file identifiers.
	///
	/// Endpoint: `GET /api/v3/episodefile`
	///
	/// Result: the episode files matching the given filters.
	///
	/// - Parameters:
	///   - seriesId: Restricts results to files belonging to the given series.
	///   - episodeFileIds: Restricts results to the given episode file identifiers.
	static func episodeFiles(seriesId: Int? = nil, episodeFileIds: [Int] = []) -> SonarrRequest<[EpisodeFileResource]> {
		var queryItems: [URLQueryItem] = []

		if let seriesId {
			queryItems.append(URLQueryItem(name: "seriesId", value: String(seriesId)))
		}

		queryItems += episodeFileIds.map { URLQueryItem(name: "episodeFileIds", value: String($0)) }

		return SonarrRequest(method: .get, path: "api/v3/episodefile", queryItems: queryItems)
	}
}

public extension SonarrRequest where SonarrResponse == EpisodeFileResource {
	/// Gets a single episode file.
	///
	/// Endpoint: `GET /api/v3/episodefile/{id}`
	///
	/// Result: the requested episode file.
	///
	/// - Parameter id: The unique identifier of the episode file.
	static func episodeFile(id: Int) -> SonarrRequest<EpisodeFileResource> {
		SonarrRequest(method: .get, path: "api/v3/episodefile/\(id)")
	}

	/// Updates an existing episode file.
	///
	/// Endpoint: `PUT /api/v3/episodefile/{id}`
	///
	/// Result: the updated episode file.
	///
	/// - Parameters:
	///   - id: The unique identifier of the episode file to update.
	///   - episodeFile: The new episode file.
	static func updateEpisodeFile(id: Int, _ episodeFile: EpisodeFileResource) -> SonarrRequest<EpisodeFileResource> {
		SonarrRequest(
			method: .put, path: "api/v3/episodefile/\(id)", body: { JSONBody(episodeFile, encoder: episodeFileEncoder) })
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Removes an episode file.
	///
	/// Endpoint: `DELETE /api/v3/episodefile/{id}`
	///
	/// - Parameter id: The unique identifier of the episode file to remove.
	static func deleteEpisodeFile(id: Int) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .delete, path: "api/v3/episodefile/\(id)")
	}

	/// Updates metadata (language, quality, scene name, release group) on multiple episode files at once.
	///
	/// Endpoint: `PUT /api/v3/episodefile/editor`
	///
	/// - Parameter edit: The episode file identifiers and metadata to apply.
	static func editEpisodeFiles(_ edit: EpisodeFileListResource) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .put, path: "api/v3/episodefile/editor", body: { JSONBody(edit) })
	}

	/// Removes multiple episode files in a single request.
	///
	/// Endpoint: `DELETE /api/v3/episodefile/bulk`
	///
	/// - Parameter delete: The episode file identifiers to remove.
	static func deleteEpisodeFiles(_ delete: EpisodeFileListResource) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .delete, path: "api/v3/episodefile/bulk", body: { JSONBody(delete) })
	}

	/// Updates multiple episode files in a single request.
	///
	/// Endpoint: `PUT /api/v3/episodefile/bulk`
	///
	/// - Parameter episodeFiles: The episode files to update.
	static func updateEpisodeFiles(_ episodeFiles: [EpisodeFileResource]) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(
			method: .put, path: "api/v3/episodefile/bulk", body: { JSONBody(episodeFiles, encoder: episodeFileEncoder) })
	}
}
