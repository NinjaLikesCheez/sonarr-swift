/// The free and total space available on a disk or mount point known to Sonarr.
public struct DiskSpaceResource: Equatable, Decodable, Sendable {
	/// The unique identifier of this disk space entry.
	public let id: Int
	/// The filesystem path of the disk or mount point.
	public let path: String?
	/// The user-facing label for the disk or mount point.
	public let label: String?
	/// The number of bytes free on the disk.
	public let freeSpace: Int64
	/// The total capacity of the disk, in bytes.
	public let totalSpace: Int64
}
