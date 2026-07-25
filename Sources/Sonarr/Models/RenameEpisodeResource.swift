/// A pending rename Sonarr would perform on an episode file to match its naming format.
public struct RenameEpisodeResource: Equatable, Decodable, Sendable {
	/// Sonarr's internal identifier for this pending rename.
	public let id: Int?
	/// The series the episode file belongs to.
	public let seriesId: Int?
	/// The season the episode file belongs to.
	public let seasonNumber: Int?
	/// The episode numbers contained in the file.
	public let episodeNumbers: [Int]?
	/// The unique identifier of the episode file to rename.
	public let episodeFileId: Int?
	/// The file's current path.
	public let existingPath: String?
	/// The path the file would be renamed to.
	public let newPath: String?
}
