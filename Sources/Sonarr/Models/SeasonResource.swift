/// A season of a series known to Sonarr.
public struct SeasonResource: Equatable, Codable, Sendable {
	/// The season number; `0` represents specials.
	public let seasonNumber: Int?
	/// Whether the season is monitored for new episodes.
	public let monitored: Bool?
	/// Aggregate file/airing statistics for the season.
	public let statistics: SeasonStatisticsResource?
	/// The artwork associated with the season.
	public let images: [MediaCover]?

	/// Creates a season value.
	/// - Parameters:
	///   - seasonNumber: The season number; `0` represents specials.
	///   - monitored: Whether the season is monitored for new episodes.
	///   - statistics: Aggregate file/airing statistics for the season.
	///   - images: The artwork associated with the season.
	public init(
		seasonNumber: Int? = nil,
		monitored: Bool? = nil,
		statistics: SeasonStatisticsResource? = nil,
		images: [MediaCover]? = nil
	) {
		self.seasonNumber = seasonNumber
		self.monitored = monitored
		self.statistics = statistics
		self.images = images
	}
}
