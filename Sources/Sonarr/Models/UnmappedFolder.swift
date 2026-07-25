/// A folder found under a root folder that isn't yet associated with a series.
public struct UnmappedFolder: Equatable, Codable, Sendable {
	/// The name of the folder.
	public let name: String?
	/// The absolute path of the folder.
	public let path: String?
	/// The path of the folder relative to its root folder.
	public let relativePath: String?

	/// Creates an unmapped folder value.
	/// - Parameters:
	///   - name: The name of the folder.
	///   - path: The absolute path of the folder.
	///   - relativePath: The path of the folder relative to its root folder.
	public init(name: String? = nil, path: String? = nil, relativePath: String? = nil) {
		self.name = name
		self.path = path
		self.relativePath = relativePath
	}
}
