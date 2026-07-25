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
}
