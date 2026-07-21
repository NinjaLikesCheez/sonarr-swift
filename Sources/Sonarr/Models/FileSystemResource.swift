/// The contents of a directory as returned by a filesystem listing.
public struct FileSystemResource: Equatable, Decodable, Sendable {
	/// The path of the parent directory, if one exists.
	public let parent: String?
	/// The subdirectories of the requested path.
	public let directories: [FileSystemModel]?
	/// The files in the requested path, present only when files were requested.
	public let files: [FileSystemModel]?
}
