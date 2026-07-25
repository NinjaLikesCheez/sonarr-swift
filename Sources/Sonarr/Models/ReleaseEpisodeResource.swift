/// An episode a release maps to.
public struct ReleaseEpisodeResource: Equatable, Codable, Sendable {
	/// Sonarr's internal identifier for the episode.
	public let id: Int
	/// The season the episode belongs to.
	public let seasonNumber: Int
	/// The episode number within its season.
	public let episodeNumber: Int
	/// The episode's absolute number across the whole series, if known.
	public let absoluteEpisodeNumber: Int?
	/// The title of the episode.
	public let title: String?

	/// Creates a release episode value.
	/// - Parameters:
	///   - id: Sonarr's internal identifier for the episode.
	///   - seasonNumber: The season the episode belongs to.
	///   - episodeNumber: The episode number within its season.
	///   - absoluteEpisodeNumber: The episode's absolute number across the whole series, if known.
	///   - title: The title of the episode.
	public init(
		id: Int,
		seasonNumber: Int,
		episodeNumber: Int,
		absoluteEpisodeNumber: Int? = nil,
		title: String? = nil
	) {
		self.id = id
		self.seasonNumber = seasonNumber
		self.episodeNumber = episodeNumber
		self.absoluteEpisodeNumber = absoluteEpisodeNumber
		self.title = title
	}
}
