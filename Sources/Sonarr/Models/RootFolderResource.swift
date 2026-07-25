/// A folder Sonarr monitors as a base location for series.
public struct RootFolderResource: Equatable, Codable, Sendable {
	/// The unique identifier of this root folder, if it has been saved.
	public let id: Int?
	/// The absolute path of the root folder.
	public let path: String?
	/// Whether the path is currently reachable by Sonarr.
	public let accessible: Bool?
	/// The free space available at the path, in bytes.
	public let freeSpace: Int64?
	/// The folders found under this root folder that aren't yet associated with a series.
	public let unmappedFolders: [UnmappedFolder]?

	/// Creates a root folder to send to the server.
	/// - Parameters:
	///   - id: The unique identifier of this root folder, if updating an existing one.
	///   - path: The absolute path of the root folder.
	///   - accessible: Whether the path is currently reachable by Sonarr.
	///   - freeSpace: The free space available at the path, in bytes.
	///   - unmappedFolders: The folders found under this root folder that aren't yet associated with a series.
	public init(
		id: Int? = nil,
		path: String? = nil,
		accessible: Bool? = nil,
		freeSpace: Int64? = nil,
		unmappedFolders: [UnmappedFolder]? = nil
	) {
		self.id = id
		self.path = path
		self.accessible = accessible
		self.freeSpace = freeSpace
		self.unmappedFolders = unmappedFolders
	}
}
