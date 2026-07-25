import Foundation

/// An item in Sonarr's download queue.
public struct QueueResource: Equatable, Decodable, Sendable {
	/// Sonarr's internal identifier for the queue item.
	public let id: Int
	/// The series the queue item belongs to, if known.
	public let seriesId: Int?
	/// The episode the queue item belongs to, if known.
	public let episodeId: Int?
	/// The season the queue item belongs to, if known.
	public let seasonNumber: Int?
	/// The series the queue item belongs to, if requested.
	public let series: SeriesResource?
	/// The episode the queue item belongs to, if requested.
	public let episode: EpisodeResource?
	/// The languages Sonarr matched for the release.
	public let languages: [Language]?
	/// The quality Sonarr matched for the release.
	public let quality: QualityModel?
	/// The custom formats Sonarr matched for the release.
	public let customFormats: [CustomFormat]?
	/// The total score of the custom formats matched for the release.
	public let customFormatScore: Int
	/// The total size of the download, in bytes.
	public let size: Double
	/// The title of the release as reported by the download client.
	public let title: String?
	/// When the download is estimated to complete.
	public let estimatedCompletionTime: Date?
	/// When the item was added to the queue.
	public let added: Date?
	/// The current state of the download.
	public let status: QueueStatus?
	/// The overall health Sonarr has assigned to the tracked download.
	public let trackedDownloadStatus: TrackedDownloadStatus?
	/// The stage of post-download processing the tracked download has reached.
	public let trackedDownloadState: TrackedDownloadState?
	/// Status messages Sonarr has attached to the tracked download.
	public let statusMessages: [TrackedDownloadStatusMessage]?
	/// The error message reported for this item, if any.
	public let errorMessage: String?
	/// The download client's identifier for this download.
	public let downloadId: String?
	/// The download protocol used to fetch the release.
	public let `protocol`: DownloadProtocol?
	/// The name of the download client handling this item.
	public let downloadClient: String?
	/// Whether the download client has a post-import category configured.
	public let downloadClientHasPostImportCategory: Bool
	/// The name of the indexer the release came from.
	public let indexer: String?
	/// The path the download is being saved to.
	public let outputPath: String?
	/// Whether the episode already has a file on disk.
	public let episodeHasFile: Bool
}
