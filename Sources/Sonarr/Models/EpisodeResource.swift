import Foundation

/// An episode known to Sonarr.
public struct EpisodeResource: Equatable, Decodable, Sendable {
	/// Sonarr's internal identifier for the episode.
	public let id: Int
	/// The series the episode belongs to.
	public let seriesId: Int
	/// The identifier of the episode on TheTVDB.
	public let tvdbId: Int
	/// The identifier of the file associated with the episode, if any.
	public let episodeFileId: Int
	/// The season the episode belongs to.
	public let seasonNumber: Int
	/// The episode's number within its season.
	public let episodeNumber: Int
	/// The title of the episode.
	public let title: String?
	/// The air date of the episode, in the series' local time zone.
	public let airDate: String?
	/// The air date and time of the episode, in UTC.
	public let airDateUtc: Date?
	/// When Sonarr last searched for this episode.
	public let lastSearchTime: Date?
	/// The runtime of the episode, in minutes.
	public let runtime: Int
	/// The type of season finale this episode represents, if any.
	public let finaleType: String?
	/// A synopsis of the episode.
	public let overview: String?
	/// The file associated with the episode, if requested and present.
	public let episodeFile: EpisodeFileResource?
	/// Whether a file is associated with the episode.
	public let hasFile: Bool
	/// Whether the episode is monitored for download.
	public let monitored: Bool
	/// The absolute episode number, for series that use absolute numbering.
	public let absoluteEpisodeNumber: Int?
	/// The scene-numbered absolute episode number, if scene numbering differs from Sonarr's.
	public let sceneAbsoluteEpisodeNumber: Int?
	/// The scene-numbered episode number, if scene numbering differs from Sonarr's.
	public let sceneEpisodeNumber: Int?
	/// The scene-numbered season number, if scene numbering differs from Sonarr's.
	public let sceneSeasonNumber: Int?
	/// Whether the scene numbering for this episode hasn't been verified.
	public let unverifiedSceneNumbering: Bool
	/// The estimated end time of the episode's airing.
	public let endTime: Date?
	/// When a release for this episode was last grabbed.
	public let grabDate: Date?
	/// The series the episode belongs to, if requested.
	public let series: SeriesResource?
	/// The artwork associated with the episode, if requested.
	public let images: [MediaCover]?
	/// Whether a release for this episode has been grabbed.
	public let grabbed: Bool
}
