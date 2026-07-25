/// A manual import candidate with corrected metadata, submitted back to Sonarr to complete the import.
public struct ManualImportReprocessResource: Equatable, Codable, Sendable {
	/// The unique identifier of the manual import candidate this reprocesses.
	public let id: Int?
	/// The full path to the file.
	public let path: String?
	/// The identifier of the series to import the file into.
	public let seriesId: Int?
	/// The season number to import the file into.
	public let seasonNumber: Int?
	/// The episodes to import the file into.
	public let episodes: [EpisodeResource]?
	/// The identifiers of the episodes to import the file into.
	public let episodeIds: [Int]?
	/// The quality to import the file as.
	public let quality: QualityModel?
	/// The languages to import the file as.
	public let languages: [Language]?
	/// The release group to import the file as.
	public let releaseGroup: String?
	/// The identifier of the download client job this file came from, if any.
	public let downloadId: String?
	/// The custom formats to import the file as.
	public let customFormats: [CustomFormatResource]?
	/// The total score across all matched custom formats.
	public let customFormatScore: Int?
	/// The indexer flags associated with the release, encoded as a bitmask.
	public let indexerFlags: Int?
	/// The kind of release the file was matched from.
	public let releaseType: ReleaseType?
	/// The reasons, if any, this candidate would be rejected from import.
	public let rejections: [ImportRejectionResource]?

	/// Creates a manual import reprocess request.
	/// - Parameters:
	///   - id: The unique identifier of the manual import candidate this reprocesses.
	///   - path: The full path to the file.
	///   - seriesId: The identifier of the series to import the file into.
	///   - seasonNumber: The season number to import the file into.
	///   - episodes: The episodes to import the file into.
	///   - episodeIds: The identifiers of the episodes to import the file into.
	///   - quality: The quality to import the file as.
	///   - languages: The languages to import the file as.
	///   - releaseGroup: The release group to import the file as.
	///   - downloadId: The identifier of the download client job this file came from, if any.
	///   - customFormats: The custom formats to import the file as.
	///   - customFormatScore: The total score across all matched custom formats.
	///   - indexerFlags: The indexer flags associated with the release, encoded as a bitmask.
	///   - releaseType: The kind of release the file was matched from.
	///   - rejections: The reasons, if any, this candidate would be rejected from import.
	public init(
		id: Int? = nil,
		path: String? = nil,
		seriesId: Int? = nil,
		seasonNumber: Int? = nil,
		episodes: [EpisodeResource]? = nil,
		episodeIds: [Int]? = nil,
		quality: QualityModel? = nil,
		languages: [Language]? = nil,
		releaseGroup: String? = nil,
		downloadId: String? = nil,
		customFormats: [CustomFormatResource]? = nil,
		customFormatScore: Int? = nil,
		indexerFlags: Int? = nil,
		releaseType: ReleaseType? = nil,
		rejections: [ImportRejectionResource]? = nil
	) {
		self.id = id
		self.path = path
		self.seriesId = seriesId
		self.seasonNumber = seasonNumber
		self.episodes = episodes
		self.episodeIds = episodeIds
		self.quality = quality
		self.languages = languages
		self.releaseGroup = releaseGroup
		self.downloadId = downloadId
		self.customFormats = customFormats
		self.customFormatScore = customFormatScore
		self.indexerFlags = indexerFlags
		self.releaseType = releaseType
		self.rejections = rejections
	}
}
