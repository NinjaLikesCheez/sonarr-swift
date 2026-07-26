import APIClient
import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public extension SonarrRequest where SonarrResponse == [ManualImportResource] {
	/// Scans a folder (or a download client job) for files that can be manually imported.
	///
	/// Endpoint: `GET /api/v3/manualimport`
	///
	/// Result: the manual import candidates found, along with any series/episode matches Sonarr inferred.
	///
	/// - Parameters:
	///   - folder: The folder to scan for importable files.
	///   - downloadId: Restricts the scan to files belonging to a specific download client job.
	///   - seriesId: Restricts the scan to files matched to a specific series.
	///   - seasonNumber: Restricts the scan to files matched to a specific season.
	///   - filterExistingFiles: Whether to exclude files that already exist as episode files. Defaults to `true`.
	static func manualImport(
		folder: String? = nil,
		downloadId: String? = nil,
		seriesId: Int? = nil,
		seasonNumber: Int? = nil,
		filterExistingFiles: Bool? = nil
	) -> SonarrRequest<[ManualImportResource]> {
		var queryItems: [URLQueryItem] = []

		if let folder {
			queryItems.append(URLQueryItem(name: "folder", value: folder))
		}

		if let downloadId {
			queryItems.append(URLQueryItem(name: "downloadId", value: downloadId))
		}

		if let seriesId {
			queryItems.append(URLQueryItem(name: "seriesId", value: String(seriesId)))
		}

		if let seasonNumber {
			queryItems.append(URLQueryItem(name: "seasonNumber", value: String(seasonNumber)))
		}

		if let filterExistingFiles {
			queryItems.append(URLQueryItem(name: "filterExistingFiles", value: String(filterExistingFiles)))
		}

		return SonarrRequest(method: .get, path: "api/v3/manualimport", queryItems: queryItems)
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Submits corrected manual import candidates to complete the import.
	///
	/// Endpoint: `POST /api/v3/manualimport`
	///
	/// - Parameter reprocessed: The manual import candidates, with corrected metadata, to import.
	static func manualImport(_ reprocessed: [ManualImportReprocessResource]) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .post, path: "api/v3/manualimport", body: { JSONBody(reprocessed, encoder: sonarrEncoder) })
	}
}
