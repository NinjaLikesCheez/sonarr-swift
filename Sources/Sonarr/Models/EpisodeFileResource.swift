import Foundation

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
	/// The scene-released name of the file, if known.
	public let sceneName: String?
	/// The release group that produced the file, if known.
	public let releaseGroup: String?
	/// The languages Sonarr matched for the file.
	public let languages: [Language]?
	/// The quality Sonarr matched for the file.
	public let quality: QualityModel
	/// The custom formats Sonarr matched for the file.
	public let customFormats: [CustomFormatResource]?
	/// The total score of the custom formats matched for the file.
	public let customFormatScore: Int
	/// The indexer flags set on the release the file was grabbed from.
	public let indexerFlags: Int?
	/// The kind of release the file was matched from.
	public let releaseType: ReleaseType
	/// Technical media metadata Sonarr extracted from the file.
	public let mediaInfo: MediaInfoResource?
	/// Whether the file's quality is below the cutoff for its quality profile.
	public let qualityCutoffNotMet: Bool

	/// Creates an episode file to send to the server.
	/// - Parameters:
	///   - id: Sonarr's internal identifier for the episode file.
	///   - seriesId: The series the file belongs to.
	///   - seasonNumber: The season the file belongs to.
	///   - relativePath: The path of the file relative to the series folder.
	///   - path: The absolute path of the file on disk.
	///   - size: The size of the file, in bytes.
	///   - dateAdded: When the file was added to Sonarr.
	///   - sceneName: The scene-released name of the file, if known.
	///   - releaseGroup: The release group that produced the file, if known.
	///   - languages: The languages Sonarr matched for the file.
	///   - quality: The quality Sonarr matched for the file.
	///   - customFormats: The custom formats Sonarr matched for the file.
	///   - customFormatScore: The total score of the custom formats matched for the file.
	///   - indexerFlags: The indexer flags set on the release the file was grabbed from.
	///   - releaseType: The kind of release the file was matched from.
	///   - mediaInfo: Technical media metadata Sonarr extracted from the file.
	///   - qualityCutoffNotMet: Whether the file's quality is below the cutoff for its quality profile.
	public init(
		id: Int,
		seriesId: Int,
		seasonNumber: Int,
		relativePath: String? = nil,
		path: String? = nil,
		size: Int,
		dateAdded: Date,
		sceneName: String? = nil,
		releaseGroup: String? = nil,
		languages: [Language]? = nil,
		quality: QualityModel,
		customFormats: [CustomFormatResource]? = nil,
		customFormatScore: Int,
		indexerFlags: Int? = nil,
		releaseType: ReleaseType,
		mediaInfo: MediaInfoResource? = nil,
		qualityCutoffNotMet: Bool
	) {
		self.id = id
		self.seriesId = seriesId
		self.seasonNumber = seasonNumber
		self.relativePath = relativePath
		self.path = path
		self.size = size
		self.dateAdded = dateAdded
		self.sceneName = sceneName
		self.releaseGroup = releaseGroup
		self.languages = languages
		self.quality = quality
		self.customFormats = customFormats
		self.customFormatScore = customFormatScore
		self.indexerFlags = indexerFlags
		self.releaseType = releaseType
		self.mediaInfo = mediaInfo
		self.qualityCutoffNotMet = qualityCutoffNotMet
	}
}
