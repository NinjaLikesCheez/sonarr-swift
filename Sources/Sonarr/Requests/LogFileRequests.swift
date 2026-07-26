import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public extension SonarrRequest where SonarrResponse == [LogFileResource] {
	/// Gets the log files available on the server.
	///
	/// Endpoint: `GET /api/v3/log/file`
	///
	/// Result: the available log files.
	static var logFiles: SonarrRequest<[LogFileResource]> {
		SonarrRequest(method: .get, path: "api/v3/log/file")
	}

	/// Gets the update log files available on the server.
	///
	/// Endpoint: `GET /api/v3/log/file/update`
	///
	/// Result: the available update log files.
	static var updateLogFiles: SonarrRequest<[LogFileResource]> {
		SonarrRequest(method: .get, path: "api/v3/log/file/update")
	}
}

public extension SonarrRequest where SonarrResponse == String {
	/// Gets the contents of a log file.
	///
	/// Endpoint: `GET /api/v3/log/file/{filename}`
	///
	/// Result: the raw contents of the log file.
	///
	/// - Parameter filename: The name of the log file to fetch, e.g. `sonarr.txt`.
	static func logFile(filename: String) -> SonarrRequest<String> {
		SonarrRequest(
			method: .get,
			path: "api/v3/log/file/\(filename)",
			transform: { data, _ in String(decoding: data, as: UTF8.self) }
		)
	}

	/// Gets the contents of an update log file.
	///
	/// Endpoint: `GET /api/v3/log/file/update/{filename}`
	///
	/// Result: the raw contents of the update log file.
	///
	/// - Parameter filename: The name of the update log file to fetch, e.g. `update.1.txt`.
	static func updateLogFile(filename: String) -> SonarrRequest<String> {
		SonarrRequest(
			method: .get,
			path: "api/v3/log/file/update/\(filename)",
			transform: { data, _ in String(decoding: data, as: UTF8.self) }
		)
	}
}
