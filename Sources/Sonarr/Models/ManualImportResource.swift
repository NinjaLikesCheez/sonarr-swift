/// A candidate file Sonarr found while scanning a folder for manual import.
public struct ManualImportResource: Equatable, Decodable, Sendable {
	/// The unique identifier of this manual import candidate.
	public let id: Int?
	/// The full path to the file.
	public let path: String?
	/// The path relative to the series' root folder.
	public let relativePath: String?
	/// The name of the folder the file was found in.
	public let folderName: String?
	/// The file's name.
	public let name: String?
	/// The size of the file, in bytes.
	public let size: Int64?
	/// The series Sonarr matched the file to.
	public let series: SeriesResource?
	/// The season number Sonarr matched the file to.
	public let seasonNumber: Int?
	/// The episodes Sonarr matched the file to.
	public let episodes: [EpisodeResource]?
	/// The identifier of the episode file this import would replace, if any.
	public let episodeFileId: Int?
	/// The release group parsed from the file name.
	public let releaseGroup: String?
	/// The quality Sonarr matched for the file.
	public let quality: QualityModel?
	/// The languages Sonarr matched for the file.
	public let languages: [Language]?
	/// The weight Sonarr assigned to the matched quality, for comparison against other candidates.
	public let qualityWeight: Int?
	/// The identifier of the download client job this file came from, if any.
	public let downloadId: String?
	/// The custom formats Sonarr matched for the file.
	public let customFormats: [CustomFormatResource]?
	/// The total score Sonarr assigned across all matched custom formats.
	public let customFormatScore: Int?
	/// The indexer flags associated with the release, encoded as a bitmask.
	public let indexerFlags: Int?
	/// The kind of release the file was matched from.
	public let releaseType: ReleaseType?
	/// The reasons, if any, this candidate would be rejected from import.
	public let rejections: [ImportRejectionResource]?
}
