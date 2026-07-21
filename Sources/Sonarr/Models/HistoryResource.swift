import Foundation

/// A single event recorded in Sonarr's history.
public struct HistoryResource: Equatable, Decodable, Sendable {
	/// Sonarr's internal identifier for the history event.
	public let id: Int
	/// The episode the event relates to.
	public let episodeId: Int
	/// The series the event relates to.
	public let seriesId: Int
	/// The title of the release as reported by the indexer.
	public let sourceTitle: String?
	/// The languages Sonarr matched for the release.
	public let languages: [Language]?
	/// The quality Sonarr matched for the release.
	public let quality: QualityModel
	/// The custom formats Sonarr matched for the release.
	public let customFormats: [CustomFormat]?
	/// The total score of the custom formats matched for the release.
	public let customFormatScore: Int
	/// Whether the matched quality is below the series' quality cutoff.
	public let qualityCutoffNotMet: Bool
	/// When the event occurred.
	public let date: Date
	/// The download client's identifier for the associated download, if any.
	public let downloadId: String?
	/// The kind of event this entry represents.
	public let eventType: EpisodeHistoryEventType
	/// Additional event-specific metadata.
	public let data: [String: String]?
	/// The episode the event relates to, if requested.
	public let episode: EpisodeResource?
	/// The series the event relates to, if requested.
	public let series: SeriesResource?
}
