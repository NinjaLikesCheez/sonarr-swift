import Foundation

/// Aggregate file/airing statistics for a season.
public struct SeasonStatisticsResource: Equatable, Codable, Sendable {
	/// When the next episode of the season airs, if known.
	public let nextAiring: Date?
	/// When the most recent episode of the season aired, if known.
	public let previousAiring: Date?
	/// The number of episodes in the season that have a file on disk.
	public let episodeFileCount: Int?
	/// The number of episodes in the season that have aired.
	public let episodeCount: Int?
	/// The total number of episodes in the season, including unaired ones.
	public let totalEpisodeCount: Int?
	/// The total size of the season's files on disk, in bytes.
	public let sizeOnDisk: Int64?
	/// The release groups Sonarr has files from for this season.
	public let releaseGroups: [String]?
	/// The percentage of aired episodes that have a file on disk.
	public let percentOfEpisodes: Double?
}
