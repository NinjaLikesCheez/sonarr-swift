/// A media file found on disk under a requested filesystem path.
public struct MediaFileResource: Equatable, Decodable, Sendable {
	/// The full filesystem path of the media file.
	public let path: String
	/// The path relative to the requested directory.
	public let relativePath: String
	/// The file name, including extension.
	public let name: String
}
