import Foundation

/// An episode known to Sonarr.
public struct EpisodeResource: Equatable, Codable, Sendable {
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

	/// Creates an episode to send to the server.
	/// - Parameters:
	///   - id: Sonarr's internal identifier for the episode.
	///   - seriesId: The series the episode belongs to.
	///   - tvdbId: The identifier of the episode on TheTVDB.
	///   - episodeFileId: The identifier of the file associated with the episode, if any.
	///   - seasonNumber: The season the episode belongs to.
	///   - episodeNumber: The episode's number within its season.
	///   - title: The title of the episode.
	///   - airDate: The air date of the episode, in the series' local time zone.
	///   - airDateUtc: The air date and time of the episode, in UTC.
	///   - lastSearchTime: When Sonarr last searched for this episode.
	///   - runtime: The runtime of the episode, in minutes.
	///   - finaleType: The type of season finale this episode represents, if any.
	///   - overview: A synopsis of the episode.
	///   - episodeFile: The file associated with the episode, if requested and present.
	///   - hasFile: Whether a file is associated with the episode.
	///   - monitored: Whether the episode is monitored for download.
	///   - absoluteEpisodeNumber: The absolute episode number, for series that use absolute numbering.
	///   - sceneAbsoluteEpisodeNumber: The scene-numbered absolute episode number, if scene numbering differs from
	///   Sonarr's.
	///   - sceneEpisodeNumber: The scene-numbered episode number, if scene numbering differs from Sonarr's.
	///   - sceneSeasonNumber: The scene-numbered season number, if scene numbering differs from Sonarr's.
	///   - unverifiedSceneNumbering: Whether the scene numbering for this episode hasn't been verified.
	///   - endTime: The estimated end time of the episode's airing.
	///   - grabDate: When a release for this episode was last grabbed.
	///   - series: The series the episode belongs to, if requested.
	///   - images: The artwork associated with the episode, if requested.
	///   - grabbed: Whether a release for this episode has been grabbed.
	public init(
		id: Int,
		seriesId: Int,
		tvdbId: Int,
		episodeFileId: Int,
		seasonNumber: Int,
		episodeNumber: Int,
		title: String? = nil,
		airDate: String? = nil,
		airDateUtc: Date? = nil,
		lastSearchTime: Date? = nil,
		runtime: Int,
		finaleType: String? = nil,
		overview: String? = nil,
		episodeFile: EpisodeFileResource? = nil,
		hasFile: Bool,
		monitored: Bool,
		absoluteEpisodeNumber: Int? = nil,
		sceneAbsoluteEpisodeNumber: Int? = nil,
		sceneEpisodeNumber: Int? = nil,
		sceneSeasonNumber: Int? = nil,
		unverifiedSceneNumbering: Bool,
		endTime: Date? = nil,
		grabDate: Date? = nil,
		series: SeriesResource? = nil,
		images: [MediaCover]? = nil,
		grabbed: Bool
	) {
		self.id = id
		self.seriesId = seriesId
		self.tvdbId = tvdbId
		self.episodeFileId = episodeFileId
		self.seasonNumber = seasonNumber
		self.episodeNumber = episodeNumber
		self.title = title
		self.airDate = airDate
		self.airDateUtc = airDateUtc
		self.lastSearchTime = lastSearchTime
		self.runtime = runtime
		self.finaleType = finaleType
		self.overview = overview
		self.episodeFile = episodeFile
		self.hasFile = hasFile
		self.monitored = monitored
		self.absoluteEpisodeNumber = absoluteEpisodeNumber
		self.sceneAbsoluteEpisodeNumber = sceneAbsoluteEpisodeNumber
		self.sceneEpisodeNumber = sceneEpisodeNumber
		self.sceneSeasonNumber = sceneSeasonNumber
		self.unverifiedSceneNumbering = unverifiedSceneNumbering
		self.endTime = endTime
		self.grabDate = grabDate
		self.series = series
		self.images = images
		self.grabbed = grabbed
	}
}
