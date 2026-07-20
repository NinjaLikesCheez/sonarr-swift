import APIClient
import Foundation

public extension SonarrRequest where SonarrResponse == CommandResource {
	/// Queues a command by name, with no additional parameters.
	///
	/// Endpoint: `POST /api/v3/command`
	///
	/// Result: the queued command, including its assigned identifier.
	///
	/// - Parameter name: The command's type name, e.g. `RssSync` or `Backup`.
	static func command(name: String) -> SonarrRequest<CommandResource> {
		SonarrRequest(method: .post, path: "api/v3/command", body: { JSONBody(NamedCommandBody(name: name)) })
	}

	/// Queues a refresh of one or more series, or of every series if none are given.
	///
	/// Endpoint: `POST /api/v3/command`
	///
	/// Result: the queued command, including its assigned identifier.
	///
	/// - Parameter seriesIds: The series to refresh. Empty refreshes every series.
	static func refreshSeries(seriesIds: [Int] = []) -> SonarrRequest<CommandResource> {
		SonarrRequest(
			method: .post,
			path: "api/v3/command",
			body: { JSONBody(RefreshSeriesCommandBody(seriesIds: seriesIds)) }
		)
	}

	/// Queues a disk rescan of a series' episode files, or of every series if none is given.
	///
	/// Endpoint: `POST /api/v3/command`
	///
	/// Result: the queued command, including its assigned identifier.
	///
	/// - Parameter seriesId: The series to rescan. `nil` rescans every series.
	static func rescanSeries(seriesId: Int? = nil) -> SonarrRequest<CommandResource> {
		SonarrRequest(
			method: .post,
			path: "api/v3/command",
			body: { JSONBody(RescanSeriesCommandBody(seriesId: seriesId)) }
		)
	}

	/// Queues an indexer search for every monitored episode of a series.
	///
	/// Endpoint: `POST /api/v3/command`
	///
	/// Result: the queued command, including its assigned identifier.
	///
	/// - Parameter seriesId: The series to search for.
	static func seriesSearch(seriesId: Int) -> SonarrRequest<CommandResource> {
		SonarrRequest(
			method: .post,
			path: "api/v3/command",
			body: { JSONBody(SeriesSearchCommandBody(seriesId: seriesId)) }
		)
	}

	/// Queues an indexer search for every monitored episode of a season.
	///
	/// Endpoint: `POST /api/v3/command`
	///
	/// Result: the queued command, including its assigned identifier.
	///
	/// - Parameters:
	///   - seriesId: The series the season belongs to.
	///   - seasonNumber: The season to search for.
	static func seasonSearch(seriesId: Int, seasonNumber: Int) -> SonarrRequest<CommandResource> {
		SonarrRequest(
			method: .post,
			path: "api/v3/command",
			body: { JSONBody(SeasonSearchCommandBody(seriesId: seriesId, seasonNumber: seasonNumber)) }
		)
	}

	/// Queues an indexer search for one or more episodes.
	///
	/// Endpoint: `POST /api/v3/command`
	///
	/// Result: the queued command, including its assigned identifier.
	///
	/// - Parameter episodeIds: The episodes to search for.
	static func episodeSearch(episodeIds: [Int]) -> SonarrRequest<CommandResource> {
		SonarrRequest(
			method: .post,
			path: "api/v3/command",
			body: { JSONBody(EpisodeSearchCommandBody(episodeIds: episodeIds)) }
		)
	}

	/// Queues a search for every monitored episode missing a file.
	///
	/// Endpoint: `POST /api/v3/command`
	///
	/// Result: the queued command, including its assigned identifier.
	///
	/// - Parameter seriesId: Restricts the search to a single series. `nil` searches every series.
	static func missingEpisodeSearch(seriesId: Int? = nil) -> SonarrRequest<CommandResource> {
		SonarrRequest(
			method: .post,
			path: "api/v3/command",
			body: { JSONBody(MissingEpisodeSearchCommandBody(seriesId: seriesId)) }
		)
	}

	/// Queues an RSS sync across all enabled indexers.
	///
	/// Endpoint: `POST /api/v3/command`
	///
	/// Result: the queued command, including its assigned identifier.
	static var rssSync: SonarrRequest<CommandResource> {
		SonarrRequest(method: .post, path: "api/v3/command", body: { JSONBody(NamedCommandBody(name: "RssSync")) })
	}

	/// Queues a rename of a series' episode files that don't match its naming format.
	///
	/// Endpoint: `POST /api/v3/command`
	///
	/// Result: the queued command, including its assigned identifier.
	///
	/// - Parameters:
	///   - seriesId: The series the files belong to.
	///   - files: The identifiers of the episode files to rename. Empty renames every mismatched file.
	static func renameFiles(seriesId: Int, files: [Int] = []) -> SonarrRequest<CommandResource> {
		SonarrRequest(
			method: .post,
			path: "api/v3/command",
			body: { JSONBody(RenameFilesCommandBody(seriesId: seriesId, files: files)) }
		)
	}

	/// Queues a database/config backup.
	///
	/// Endpoint: `POST /api/v3/command`
	///
	/// Result: the queued command, including its assigned identifier.
	static var backup: SonarrRequest<CommandResource> {
		SonarrRequest(method: .post, path: "api/v3/command", body: { JSONBody(NamedCommandBody(name: "Backup")) })
	}

	/// Gets a single command by identifier.
	///
	/// Endpoint: `GET /api/v3/command/{id}`
	///
	/// Result: the requested command.
	///
	/// - Parameter id: The command's unique identifier.
	static func command(id: Int) -> SonarrRequest<CommandResource> {
		SonarrRequest(method: .get, path: "api/v3/command/\(id)")
	}
}

public extension SonarrRequest where SonarrResponse == [CommandResource] {
	/// Gets every command Sonarr currently knows about, running or finished.
	///
	/// Endpoint: `GET /api/v3/command`
	///
	/// Result: the known commands.
	static var commands: SonarrRequest<[CommandResource]> {
		SonarrRequest(method: .get, path: "api/v3/command")
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Cancels a running or queued command.
	///
	/// Endpoint: `DELETE /api/v3/command/{id}`
	///
	/// - Parameter id: The identifier of the command to cancel.
	static func cancelCommand(id: Int) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .delete, path: "api/v3/command/\(id)")
	}
}

/// Request body for a command with no parameters beyond its name.
private struct NamedCommandBody: Encodable {
	let name: String
}

private struct RefreshSeriesCommandBody: Encodable {
	let name = "RefreshSeries"
	let seriesIds: [Int]
}

private struct RescanSeriesCommandBody: Encodable {
	let name = "RescanSeries"
	let seriesId: Int?
}

private struct SeriesSearchCommandBody: Encodable {
	let name = "SeriesSearch"
	let seriesId: Int
}

private struct SeasonSearchCommandBody: Encodable {
	let name = "SeasonSearch"
	let seriesId: Int
	let seasonNumber: Int
}

private struct EpisodeSearchCommandBody: Encodable {
	let name = "EpisodeSearch"
	let episodeIds: [Int]
}

private struct MissingEpisodeSearchCommandBody: Encodable {
	let name = "MissingEpisodeSearch"
	let seriesId: Int?
}

private struct RenameFilesCommandBody: Encodable {
	let name = "RenameFiles"
	let seriesId: Int
	let files: [Int]
}
