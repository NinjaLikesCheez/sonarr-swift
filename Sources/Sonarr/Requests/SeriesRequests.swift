import APIClient
import Foundation

public extension SonarrRequest where SonarrResponse == [SeriesResource] {
	/// Gets all saved series, or the series matching a specific TVDB identifier.
	///
	/// Endpoint: `GET /api/v3/series`
	///
	/// Result: the saved series matching the given filters.
	///
	/// - Parameters:
	///   - tvdbId: Restricts results to the series with the given TVDB identifier.
	///   - includeSeasonImages: Whether to attach artwork to each season.
	static func series(
		tvdbId: Int? = nil,
		includeSeasonImages: Bool = false
	) -> SonarrRequest<[SeriesResource]> {
		var queryItems: [URLQueryItem] = [
			URLQueryItem(name: "includeSeasonImages", value: String(includeSeasonImages))
		]

		if let tvdbId {
			queryItems.append(URLQueryItem(name: "tvdbId", value: String(tvdbId)))
		}

		return SonarrRequest(method: .get, path: "api/v3/series", queryItems: queryItems)
	}

	/// Bulk-imports existing series from disk.
	///
	/// Endpoint: `POST /api/v3/series/import`
	///
	/// Result: the imported series.
	///
	/// - Parameter series: The series to import.
	static func importSeries(_ series: [SeriesResource]) -> SonarrRequest<[SeriesResource]> {
		SonarrRequest(method: .post, path: "api/v3/series/import", body: { JSONBody(series) })
	}
}

public extension SonarrRequest where SonarrResponse == SeriesResource {
	/// Adds a new series.
	///
	/// Endpoint: `POST /api/v3/series`
	///
	/// Result: the added series.
	///
	/// - Parameter series: The series to add.
	static func addSeries(_ series: SeriesResource) -> SonarrRequest<SeriesResource> {
		SonarrRequest(method: .post, path: "api/v3/series", body: { JSONBody(series) })
	}

	/// Gets a single series.
	///
	/// Endpoint: `GET /api/v3/series/{id}`
	///
	/// Result: the requested series.
	///
	/// - Parameters:
	///   - id: The unique identifier of the series.
	///   - includeSeasonImages: Whether to attach artwork to each season.
	static func series(id: Int, includeSeasonImages: Bool = false) -> SonarrRequest<SeriesResource> {
		SonarrRequest(
			method: .get,
			path: "api/v3/series/\(id)",
			queryItems: [URLQueryItem(name: "includeSeasonImages", value: String(includeSeasonImages))]
		)
	}

	/// Updates an existing series.
	///
	/// Endpoint: `PUT /api/v3/series/{id}`
	///
	/// Result: the updated series.
	///
	/// - Parameters:
	///   - id: The unique identifier of the series to update.
	///   - series: The new series.
	///   - moveFiles: Whether to move the series' files to its new path, if the path changed.
	static func updateSeries(
		id: Int,
		_ series: SeriesResource,
		moveFiles: Bool = false
	) -> SonarrRequest<SeriesResource> {
		SonarrRequest(
			method: .put,
			path: "api/v3/series/\(id)",
			queryItems: [URLQueryItem(name: "moveFiles", value: String(moveFiles))],
			body: { JSONBody(series) }
		)
	}
}

public extension SonarrRequest where SonarrResponse == SeriesFolderResource {
	/// Gets the folder name Sonarr would use for a series.
	///
	/// Endpoint: `GET /api/v3/series/{id}/folder`
	///
	/// Result: the series' folder name.
	///
	/// - Parameter id: The unique identifier of the series.
	static func seriesFolder(id: Int) -> SonarrRequest<SeriesFolderResource> {
		SonarrRequest(method: .get, path: "api/v3/series/\(id)/folder")
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Deletes a series.
	///
	/// Endpoint: `DELETE /api/v3/series/{id}`
	///
	/// - Parameters:
	///   - id: The unique identifier of the series to delete.
	///   - deleteFiles: Whether to also delete the series' files from disk.
	///   - addImportListExclusion: Whether to prevent the series from being re-added by an import list.
	static func deleteSeries(
		id: Int,
		deleteFiles: Bool = false,
		addImportListExclusion: Bool = false
	) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(
			method: .delete,
			path: "api/v3/series/\(id)",
			queryItems: [
				URLQueryItem(name: "deleteFiles", value: String(deleteFiles)),
				URLQueryItem(name: "addImportListExclusion", value: String(addImportListExclusion)),
			]
		)
	}

	/// Bulk-edits multiple series at once.
	///
	/// Endpoint: `PUT /api/v3/series/editor`
	///
	/// - Parameter seriesEditor: The changes to apply to the given series.
	static func editSeries(_ seriesEditor: SeriesEditorResource) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .put, path: "api/v3/series/editor", body: { JSONBody(seriesEditor) })
	}

	/// Bulk-deletes multiple series at once.
	///
	/// Endpoint: `DELETE /api/v3/series/editor`
	///
	/// - Parameter seriesEditor: The series to delete and how to delete them.
	static func deleteSeries(inBulk seriesEditor: SeriesEditorResource) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .delete, path: "api/v3/series/editor", body: { JSONBody(seriesEditor) })
	}
}
