import Foundation

/// A single directory, file, or drive entry returned by a filesystem listing.
public struct FileSystemModel: Equatable, Decodable, Sendable {
	/// The kind of entity this entry represents.
	public let type: FileSystemEntityType
	/// The display name of the entry.
	public let name: String?
	/// The full filesystem path of the entry.
	public let path: String?
	/// The file extension, present only for file entries.
	public let `extension`: String?
	/// The size of the entry in bytes, present only for file entries.
	public let size: Int64?
	/// When the entry was last modified, if known.
	public let lastModified: Date?
}
