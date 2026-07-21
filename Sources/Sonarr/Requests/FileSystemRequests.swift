import APIClient
import Foundation

public extension SonarrRequest where SonarrResponse == FileSystemResource {
	/// Lists the contents of a directory on the Sonarr server's filesystem.
	///
	/// Endpoint: `GET /api/v3/filesystem`
	///
	/// Result: the parent path, subdirectories, and (if requested) files of the given path.
	///
	/// - Parameters:
	///   - path: The directory to list. Omit to list drives (Windows) or the root (`/`). Without a
	///     trailing separator, or `allowFoldersWithoutTrailingSlashes`, the server lists the parent
	///     of `path` rather than `path` itself, since it treats everything after the last separator
	///     as a partial name to filter by.
	///   - includeFiles: Whether to include files alongside subdirectories.
	///   - allowFoldersWithoutTrailingSlashes: Whether `path` may be treated as a folder even
	///     without a trailing separator.
	static func fileSystem(
		path: String? = nil,
		includeFiles: Bool = false,
		allowFoldersWithoutTrailingSlashes: Bool = false
	) -> SonarrRequest<FileSystemResource> {
		var queryItems: [URLQueryItem] = [
			URLQueryItem(name: "includeFiles", value: String(includeFiles)),
			URLQueryItem(name: "allowFoldersWithoutTrailingSlashes", value: String(allowFoldersWithoutTrailingSlashes)),
		]

		if let path {
			queryItems.append(URLQueryItem(name: "path", value: path))
		}

		return SonarrRequest(method: .get, path: "api/v3/filesystem", queryItems: queryItems)
	}
}

public extension SonarrRequest where SonarrResponse == FileSystemEntityTypeResource {
	/// Determines whether a filesystem path is a file or a folder.
	///
	/// Endpoint: `GET /api/v3/filesystem/type`
	///
	/// Result: `.file` if a file exists at the given path, `.folder` otherwise.
	///
	/// - Parameter path: The filesystem path to check.
	static func fileSystemEntityType(path: String) -> SonarrRequest<FileSystemEntityTypeResource> {
		SonarrRequest(
			method: .get,
			path: "api/v3/filesystem/type",
			queryItems: [URLQueryItem(name: "path", value: path)]
		)
	}
}

public extension SonarrRequest where SonarrResponse == [MediaFileResource] {
	/// Lists the video files found under a directory on the Sonarr server's filesystem.
	///
	/// Endpoint: `GET /api/v3/filesystem/mediafiles`
	///
	/// Result: the media files found under the given path, empty if the folder doesn't exist.
	///
	/// - Parameter path: The directory to scan for media files.
	static func fileSystemMediaFiles(path: String) -> SonarrRequest<[MediaFileResource]> {
		SonarrRequest(
			method: .get,
			path: "api/v3/filesystem/mediafiles",
			queryItems: [URLQueryItem(name: "path", value: path)]
		)
	}
}
