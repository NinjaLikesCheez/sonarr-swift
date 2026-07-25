/// Aggregate file/episode statistics for a series.
public struct SeriesStatisticsResource: Equatable, Codable, Sendable {
	/// The number of seasons the series has.
	public let seasonCount: Int?
	/// The number of episodes across the series that have a file on disk.
	public let episodeFileCount: Int?
	/// The number of episodes across the series that have aired.
	public let episodeCount: Int?
	/// The total number of episodes across the series, including unaired ones.
	public let totalEpisodeCount: Int?
	/// The total size of the series' files on disk, in bytes.
	public let sizeOnDisk: Int64?
	/// The release groups Sonarr has files from for this series.
	public let releaseGroups: [String]?
	/// The percentage of aired episodes that have a file on disk.
	public let percentOfEpisodes: Double?
}
