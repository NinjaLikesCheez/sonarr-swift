/// The free and total space available on a disk or mount point known to Sonarr.
public struct DiskSpaceResource: Equatable, Decodable, Sendable {
	// Sonarr's OpenAPI spec marks `id` as required, but the live server omits it from
	// `GET /api/v3/diskspace` responses — disk space entries are computed on the fly, not
	// persisted records with an ID.
	/// The unique identifier of this disk space entry, if the server provides one.
	public let id: Int?
	/// The filesystem path of the disk or mount point.
	public let path: String?
	/// The user-facing label for the disk or mount point.
	public let label: String?
	/// The number of bytes free on the disk.
	public let freeSpace: Int64
	/// The total capacity of the disk, in bytes.
	public let totalSpace: Int64
}
