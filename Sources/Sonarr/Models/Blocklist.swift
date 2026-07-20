import Foundation

/// A release Sonarr has blocklisted, preventing it from being grabbed again.
public struct Blocklist: Equatable, Decodable, Sendable {
	/// Sonarr's internal identifier for the blocklist entry.
	public let id: Int
	/// The series the blocklisted release belongs to.
	public let seriesId: Int
	/// The episodes covered by the blocklisted release.
	public let episodeIds: [Int]
	/// The title of the release as reported by the indexer.
	public let sourceTitle: String
	/// The languages Sonarr matched for the release.
	public let languages: [Language]
	/// The quality Sonarr matched for the release.
	public let quality: QualityModel
	/// The custom formats Sonarr matched for the release.
	public let customFormats: [CustomFormat]?
	/// When the release was blocklisted.
	public let date: Date
	/// The download protocol used to fetch the release.
	public let `protocol`: DownloadProtocol
	/// The name of the indexer the release came from.
	public let indexer: String?
	/// The reason the release was blocklisted, if known.
	public let message: String?
}
