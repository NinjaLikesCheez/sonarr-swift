import Foundation

// Minimal projection of Sonarr's EpisodeFileResource - only the fields needed by endpoints outside
// the EpisodeFile tag (e.g. Calendar's `includeEpisodeFile`). The full resource will be fleshed out
// when the EpisodeFile tag itself is implemented.

/// A media file on disk associated with an episode.
public struct EpisodeFileResource: Equatable, Codable, Sendable {
	/// Sonarr's internal identifier for the episode file.
	public let id: Int
	/// The series the file belongs to.
	public let seriesId: Int
	/// The season the file belongs to.
	public let seasonNumber: Int
	/// The path of the file relative to the series folder.
	public let relativePath: String?
	/// The absolute path of the file on disk.
	public let path: String?
	/// The size of the file, in bytes.
	public let size: Int
	/// When the file was added to Sonarr.
	public let dateAdded: Date
	/// The languages Sonarr matched for the file.
	public let languages: [Language]?
	/// The quality Sonarr matched for the file.
	public let quality: QualityModel
	/// The custom formats Sonarr matched for the file.
	public let customFormats: [CustomFormat]?
}
