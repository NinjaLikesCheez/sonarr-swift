/// Whether a filesystem path is a file or a folder.
public struct FileSystemEntityTypeResource: Equatable, Decodable, Sendable {
	/// The kind of entity found at the requested path.
	public let type: FileSystemEntityType
}
