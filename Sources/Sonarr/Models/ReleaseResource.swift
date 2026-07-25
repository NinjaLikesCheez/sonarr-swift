import Foundation

/// A release found by searching indexers, either as a search result or a grab request.
public struct ReleaseResource: Equatable, Codable, Sendable {
	/// Sonarr's internal identifier for the release, if any.
	public let id: Int?
	/// The indexer's unique identifier for the release.
	public let guid: String?
	/// The quality Sonarr matched for the release.
	public let quality: QualityModel?
	/// The weight Sonarr assigned the matched quality when ranking releases.
	public let qualityWeight: Int?
	/// The age of the release, in days.
	public let age: Int?
	/// The age of the release, in hours.
	public let ageHours: Double?
	/// The age of the release, in minutes.
	public let ageMinutes: Double?
	/// The size of the release, in bytes.
	public let size: Int64?
	/// The unique identifier of the indexer the release came from.
	public let indexerId: Int?
	/// The name of the indexer the release came from.
	public let indexer: String?
	/// The release group that produced the release, if known.
	public let releaseGroup: String?
	/// The sub-group within the release group, if known.
	public let subGroup: String?
	/// A hash Sonarr uses to detect duplicate releases across indexers.
	public let releaseHash: String?
	/// The title of the release as reported by the indexer.
	public let title: String?
	/// Whether the release contains a full season.
	public let fullSeason: Bool?
	/// Whether the release originated from a scene group.
	public let sceneSource: Bool?
	/// The season the release belongs to.
	public let seasonNumber: Int?
	/// The languages Sonarr matched for the release.
	public let languages: [Language]?
	/// The weight Sonarr assigned the matched languages when ranking releases.
	public let languageWeight: Int?
	/// The air date of the episode the release matches, if applicable.
	public let airDate: String?
	/// The title of the series as reported by the indexer.
	public let seriesTitle: String?
	/// The episode numbers the release matches, within its matched season.
	public let episodeNumbers: [Int]?
	/// The absolute episode numbers the release matches.
	public let absoluteEpisodeNumbers: [Int]?
	/// The season number Sonarr mapped the release to, if different from `seasonNumber`.
	public let mappedSeasonNumber: Int?
	/// The episode numbers Sonarr mapped the release to, if different from `episodeNumbers`.
	public let mappedEpisodeNumbers: [Int]?
	/// The absolute episode numbers Sonarr mapped the release to.
	public let mappedAbsoluteEpisodeNumbers: [Int]?
	/// The unique identifier of the series Sonarr mapped the release to.
	public let mappedSeriesId: Int?
	/// The episodes Sonarr mapped the release to.
	public let mappedEpisodeInfo: [ReleaseEpisodeResource]?
	/// Whether the release passed all of Sonarr's decision rules.
	public let approved: Bool?
	/// Whether the release is temporarily rejected, e.g. pending a delay profile.
	public let temporarilyRejected: Bool?
	/// Whether the release was rejected outright.
	public let rejected: Bool?
	/// The identifier of the series on TheTVDB.
	public let tvdbId: Int?
	/// The identifier of the series on TVRage, if known.
	public let tvRageId: Int?
	/// The identifier of the series on IMDb, if known.
	public let imdbId: String?
	/// The reasons the release was rejected, if any.
	public let rejections: [String]?
	/// When the release was published by the indexer.
	public let publishDate: Date?
	/// A URL to the indexer's comments/discussion page for the release, if any.
	public let commentUrl: String?
	/// The URL to download the release from.
	public let downloadUrl: String?
	/// A URL to the indexer's info page for the release, if any.
	public let infoUrl: String?
	/// Whether this release was requested directly by the user, rather than found by search.
	public let episodeRequested: Bool?
	/// Whether Sonarr is allowed to grab this release.
	public let downloadAllowed: Bool?
	/// The overall weight Sonarr assigned the release when ranking it against others.
	public let releaseWeight: Int?
	/// The custom formats Sonarr matched for the release.
	public let customFormats: [CustomFormatResource]?
	/// The total score of the custom formats matched for the release.
	public let customFormatScore: Int?
	/// The alternate title Sonarr matched the release against, if any.
	public let sceneMapping: AlternateTitleResource?
	/// The magnet URL for the release, if fetched via torrent.
	public let magnetUrl: String?
	/// The torrent info hash for the release, if fetched via torrent.
	public let infoHash: String?
	/// The number of seeders reported for the release, if fetched via torrent.
	public let seeders: Int?
	/// The number of leechers reported for the release, if fetched via torrent.
	public let leechers: Int?
	/// The download protocol used to fetch the release.
	public let `protocol`: DownloadProtocol?
	/// A bitmask of indexer-specific flags set on the release.
	public let indexerFlags: Int?
	/// Whether the release is a daily (date-based) episode.
	public let isDaily: Bool?
	/// Whether the release uses absolute episode numbering.
	public let isAbsoluteNumbering: Bool?
	/// Whether the release is possibly a special episode.
	public let isPossibleSpecialEpisode: Bool?
	/// Whether the release is a special episode.
	public let special: Bool?
	/// The unique identifier of the series the release matches, if known.
	public let seriesId: Int?
	/// The unique identifier of the episode the release matches, if known.
	public let episodeId: Int?
	/// The unique identifiers of the episodes the release matches, if known.
	public let episodeIds: [Int]?
	/// The unique identifier of the download client that grabbed this release, if any.
	public let downloadClientId: Int?
	/// The name of the download client that grabbed this release, if any.
	public let downloadClient: String?
	/// Whether Sonarr should override its normal quality/upgrade rules when grabbing this release.
	public let shouldOverride: Bool?

	/// Creates a release value.
	/// - Parameters:
	///   - id: Sonarr's internal identifier for the release, if any.
	///   - guid: The indexer's unique identifier for the release.
	///   - quality: The quality Sonarr matched for the release.
	///   - qualityWeight: The weight Sonarr assigned the matched quality when ranking releases.
	///   - age: The age of the release, in days.
	///   - ageHours: The age of the release, in hours.
	///   - ageMinutes: The age of the release, in minutes.
	///   - size: The size of the release, in bytes.
	///   - indexerId: The unique identifier of the indexer the release came from.
	///   - indexer: The name of the indexer the release came from.
	///   - releaseGroup: The release group that produced the release, if known.
	///   - subGroup: The sub-group within the release group, if known.
	///   - releaseHash: A hash Sonarr uses to detect duplicate releases across indexers.
	///   - title: The title of the release as reported by the indexer.
	///   - fullSeason: Whether the release contains a full season.
	///   - sceneSource: Whether the release originated from a scene group.
	///   - seasonNumber: The season the release belongs to.
	///   - languages: The languages Sonarr matched for the release.
	///   - languageWeight: The weight Sonarr assigned the matched languages when ranking releases.
	///   - airDate: The air date of the episode the release matches, if applicable.
	///   - seriesTitle: The title of the series as reported by the indexer.
	///   - episodeNumbers: The episode numbers the release matches, within its matched season.
	///   - absoluteEpisodeNumbers: The absolute episode numbers the release matches.
	///   - mappedSeasonNumber: The season number Sonarr mapped the release to, if different from `seasonNumber`.
	///   - mappedEpisodeNumbers: The episode numbers Sonarr mapped the release to, if different from `episodeNumbers`.
	///   - mappedAbsoluteEpisodeNumbers: The absolute episode numbers Sonarr mapped the release to.
	///   - mappedSeriesId: The unique identifier of the series Sonarr mapped the release to.
	///   - mappedEpisodeInfo: The episodes Sonarr mapped the release to.
	///   - approved: Whether the release passed all of Sonarr's decision rules.
	///   - temporarilyRejected: Whether the release is temporarily rejected, e.g. pending a delay profile.
	///   - rejected: Whether the release was rejected outright.
	///   - tvdbId: The identifier of the series on TheTVDB.
	///   - tvRageId: The identifier of the series on TVRage, if known.
	///   - imdbId: The identifier of the series on IMDb, if known.
	///   - rejections: The reasons the release was rejected, if any.
	///   - publishDate: When the release was published by the indexer.
	///   - commentUrl: A URL to the indexer's comments/discussion page for the release, if any.
	///   - downloadUrl: The URL to download the release from.
	///   - infoUrl: A URL to the indexer's info page for the release, if any.
	///   - episodeRequested: Whether this release was requested directly by the user, rather than found by search.
	///   - downloadAllowed: Whether Sonarr is allowed to grab this release.
	///   - releaseWeight: The overall weight Sonarr assigned the release when ranking it against others.
	///   - customFormats: The custom formats Sonarr matched for the release.
	///   - customFormatScore: The total score of the custom formats matched for the release.
	///   - sceneMapping: The alternate title Sonarr matched the release against, if any.
	///   - magnetUrl: The magnet URL for the release, if fetched via torrent.
	///   - infoHash: The torrent info hash for the release, if fetched via torrent.
	///   - seeders: The number of seeders reported for the release, if fetched via torrent.
	///   - leechers: The number of leechers reported for the release, if fetched via torrent.
	///   - protocol: The download protocol used to fetch the release.
	///   - indexerFlags: A bitmask of indexer-specific flags set on the release.
	///   - isDaily: Whether the release is a daily (date-based) episode.
	///   - isAbsoluteNumbering: Whether the release uses absolute episode numbering.
	///   - isPossibleSpecialEpisode: Whether the release is possibly a special episode.
	///   - special: Whether the release is a special episode.
	///   - seriesId: The unique identifier of the series the release matches, if known.
	///   - episodeId: The unique identifier of the episode the release matches, if known.
	///   - episodeIds: The unique identifiers of the episodes the release matches, if known.
	///   - downloadClientId: The unique identifier of the download client that grabbed this release, if any.
	///   - downloadClient: The name of the download client that grabbed this release, if any.
	///   - shouldOverride: Whether Sonarr should override its normal quality/upgrade rules when grabbing this release.
	public init(
		id: Int? = nil,
		guid: String? = nil,
		quality: QualityModel? = nil,
		qualityWeight: Int? = nil,
		age: Int? = nil,
		ageHours: Double? = nil,
		ageMinutes: Double? = nil,
		size: Int64? = nil,
		indexerId: Int? = nil,
		indexer: String? = nil,
		releaseGroup: String? = nil,
		subGroup: String? = nil,
		releaseHash: String? = nil,
		title: String? = nil,
		fullSeason: Bool? = nil,
		sceneSource: Bool? = nil,
		seasonNumber: Int? = nil,
		languages: [Language]? = nil,
		languageWeight: Int? = nil,
		airDate: String? = nil,
		seriesTitle: String? = nil,
		episodeNumbers: [Int]? = nil,
		absoluteEpisodeNumbers: [Int]? = nil,
		mappedSeasonNumber: Int? = nil,
		mappedEpisodeNumbers: [Int]? = nil,
		mappedAbsoluteEpisodeNumbers: [Int]? = nil,
		mappedSeriesId: Int? = nil,
		mappedEpisodeInfo: [ReleaseEpisodeResource]? = nil,
		approved: Bool? = nil,
		temporarilyRejected: Bool? = nil,
		rejected: Bool? = nil,
		tvdbId: Int? = nil,
		tvRageId: Int? = nil,
		imdbId: String? = nil,
		rejections: [String]? = nil,
		publishDate: Date? = nil,
		commentUrl: String? = nil,
		downloadUrl: String? = nil,
		infoUrl: String? = nil,
		episodeRequested: Bool? = nil,
		downloadAllowed: Bool? = nil,
		releaseWeight: Int? = nil,
		customFormats: [CustomFormatResource]? = nil,
		customFormatScore: Int? = nil,
		sceneMapping: AlternateTitleResource? = nil,
		magnetUrl: String? = nil,
		infoHash: String? = nil,
		seeders: Int? = nil,
		leechers: Int? = nil,
		protocol: DownloadProtocol? = nil,
		indexerFlags: Int? = nil,
		isDaily: Bool? = nil,
		isAbsoluteNumbering: Bool? = nil,
		isPossibleSpecialEpisode: Bool? = nil,
		special: Bool? = nil,
		seriesId: Int? = nil,
		episodeId: Int? = nil,
		episodeIds: [Int]? = nil,
		downloadClientId: Int? = nil,
		downloadClient: String? = nil,
		shouldOverride: Bool? = nil
	) {
		self.id = id
		self.guid = guid
		self.quality = quality
		self.qualityWeight = qualityWeight
		self.age = age
		self.ageHours = ageHours
		self.ageMinutes = ageMinutes
		self.size = size
		self.indexerId = indexerId
		self.indexer = indexer
		self.releaseGroup = releaseGroup
		self.subGroup = subGroup
		self.releaseHash = releaseHash
		self.title = title
		self.fullSeason = fullSeason
		self.sceneSource = sceneSource
		self.seasonNumber = seasonNumber
		self.languages = languages
		self.languageWeight = languageWeight
		self.airDate = airDate
		self.seriesTitle = seriesTitle
		self.episodeNumbers = episodeNumbers
		self.absoluteEpisodeNumbers = absoluteEpisodeNumbers
		self.mappedSeasonNumber = mappedSeasonNumber
		self.mappedEpisodeNumbers = mappedEpisodeNumbers
		self.mappedAbsoluteEpisodeNumbers = mappedAbsoluteEpisodeNumbers
		self.mappedSeriesId = mappedSeriesId
		self.mappedEpisodeInfo = mappedEpisodeInfo
		self.approved = approved
		self.temporarilyRejected = temporarilyRejected
		self.rejected = rejected
		self.tvdbId = tvdbId
		self.tvRageId = tvRageId
		self.imdbId = imdbId
		self.rejections = rejections
		self.publishDate = publishDate
		self.commentUrl = commentUrl
		self.downloadUrl = downloadUrl
		self.infoUrl = infoUrl
		self.episodeRequested = episodeRequested
		self.downloadAllowed = downloadAllowed
		self.releaseWeight = releaseWeight
		self.customFormats = customFormats
		self.customFormatScore = customFormatScore
		self.sceneMapping = sceneMapping
		self.magnetUrl = magnetUrl
		self.infoHash = infoHash
		self.seeders = seeders
		self.leechers = leechers
		self.protocol = `protocol`
		self.indexerFlags = indexerFlags
		self.isDaily = isDaily
		self.isAbsoluteNumbering = isAbsoluteNumbering
		self.isPossibleSpecialEpisode = isPossibleSpecialEpisode
		self.special = special
		self.seriesId = seriesId
		self.episodeId = episodeId
		self.episodeIds = episodeIds
		self.downloadClientId = downloadClientId
		self.downloadClient = downloadClient
		self.shouldOverride = shouldOverride
	}
}
