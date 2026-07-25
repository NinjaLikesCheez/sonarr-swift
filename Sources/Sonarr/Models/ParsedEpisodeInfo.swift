/// The episode/series information Sonarr parsed out of a release title or file path.
public struct ParsedEpisodeInfo: Equatable, Decodable, Sendable {
	/// The full, unparsed release title.
	public let releaseTitle: String?
	/// The series title parsed from the release, as a plain string.
	public let seriesTitle: String?
	/// The series title parsed from the release, with additional detail (year, alternate titles).
	public let seriesTitleInfo: SeriesTitleInfo?
	/// The quality Sonarr matched for the release.
	public let quality: QualityModel?
	/// The season number parsed from the release.
	public let seasonNumber: Int?
	/// The episode numbers parsed from the release.
	public let episodeNumbers: [Int]?
	/// The absolute episode numbers parsed from the release, for series that use absolute numbering.
	public let absoluteEpisodeNumbers: [Int]?
	/// The absolute episode numbers parsed for special episodes, which may be fractional.
	public let specialAbsoluteEpisodeNumbers: [Double]?
	/// The air date parsed from the release, for daily series.
	public let airDate: String?
	/// The languages parsed from the release.
	public let languages: [Language]?
	/// Whether the release represents a full season.
	public let fullSeason: Bool?
	/// Whether the release represents part of a season rather than the whole thing.
	public let isPartialSeason: Bool?
	/// Whether the release spans multiple seasons.
	public let isMultiSeason: Bool?
	/// Whether the release is a season extra (e.g. behind-the-scenes content).
	public let isSeasonExtra: Bool?
	/// Whether the release is a single episode split across multiple files.
	public let isSplitEpisode: Bool?
	/// Whether the release is part of a mini-series.
	public let isMiniSeries: Bool?
	/// Whether the release is a special episode.
	public let special: Bool?
	/// The release group parsed from the release title.
	public let releaseGroup: String?
	/// The release hash parsed from the release title, if present.
	public let releaseHash: String?
	/// The season part number, for seasons split into multiple parts.
	public let seasonPart: Int?
	/// The raw tokens Sonarr extracted from the release title during parsing.
	public let releaseTokens: String?
	/// The daily part number, for series with multiple daily releases.
	public let dailyPart: Int?
	/// Whether the release was parsed as a daily episode.
	public let isDaily: Bool?
	/// Whether the release was parsed using absolute episode numbering.
	public let isAbsoluteNumbering: Bool?
	/// Whether the release could possibly be a special episode.
	public let isPossibleSpecialEpisode: Bool?
	/// Whether the release could possibly be a scene-numbered season special.
	public let isPossibleSceneSeasonSpecial: Bool?
	/// The kind of release this was parsed as.
	public let releaseType: ReleaseType?
}
