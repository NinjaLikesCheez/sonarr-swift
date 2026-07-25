import Foundation

/// A series known to Sonarr.
public struct SeriesResource: Equatable, Codable, Sendable {
	/// Sonarr's internal identifier for the series.
	public let id: Int?
	/// The title of the series.
	public let title: String?
	/// Alternate titles Sonarr matches releases against.
	public let alternateTitles: [AlternateTitleResource]?
	/// The title used for sorting.
	public let sortTitle: String?
	/// The airing status of the series.
	public let status: SeriesStatusType?
	/// Whether the series has finished airing.
	public let ended: Bool?
	/// The name of the quality profile applied to the series.
	public let profileName: String?
	/// A synopsis of the series.
	public let overview: String?
	/// When the next episode airs, if known.
	public let nextAiring: Date?
	/// When the most recent episode aired, if known.
	public let previousAiring: Date?
	/// The broadcast network the series airs on.
	public let network: String?
	/// The local time of day the series airs, e.g. `20:00`.
	public let airTime: String?
	/// The artwork associated with the series.
	public let images: [MediaCover]?
	/// The language the series originally aired in.
	public let originalLanguage: Language?
	/// A URL to a remotely hosted poster image, used when adding the series.
	public let remotePoster: String?
	/// The seasons of the series.
	public let seasons: [SeasonResource]?
	/// The year the series first aired.
	public let year: Int?
	/// The folder the series' files are stored in.
	public let path: String?
	/// The identifier of the quality profile applied to the series.
	public let qualityProfileId: Int?
	/// Whether each season has its own subfolder under the series folder.
	public let seasonFolder: Bool?
	/// Whether the series is monitored for new episodes.
	public let monitored: Bool?
	/// Whether newly added seasons/episodes are monitored.
	public let monitorNewItems: NewItemMonitorType?
	/// Whether Sonarr uses scene numbering to match this series' episodes.
	public let useSceneNumbering: Bool?
	/// The runtime of a typical episode, in minutes.
	public let runtime: Int?
	/// The identifier of the series on TheTVDB.
	public let tvdbId: Int?
	/// The identifier of the series on TVRage, if known.
	public let tvRageId: Int?
	/// The identifier of the series on TVMaze, if known.
	public let tvMazeId: Int?
	/// The identifier of the series on TheMovieDB, if known.
	public let tmdbId: Int?
	/// When the series first aired.
	public let firstAired: Date?
	/// When the series most recently aired.
	public let lastAired: Date?
	/// The scheduling type of the series.
	public let seriesType: SeriesType?
	/// A normalized version of the title used for matching.
	public let cleanTitle: String?
	/// The identifier of the series on IMDb, if known.
	public let imdbId: String?
	/// A URL-safe version of the title, used to build Sonarr's web UI links.
	public let titleSlug: String?
	/// The root folder the series' folder is stored under.
	public let rootFolderPath: String?
	/// The name of the series' folder.
	public let folder: String?
	/// The content rating of the series, e.g. `TV-14`.
	public let certification: String?
	/// The genres associated with the series.
	public let genres: [String]?
	/// The identifiers of the tags applied to the series.
	public let tags: [Int]?
	/// When the series was added to Sonarr.
	public let added: Date?
	/// Options used when the series was added, or to apply when adding it.
	public let addOptions: AddSeriesOptions?
	/// The aggregate rating for the series.
	public let ratings: Ratings?
	/// Aggregate file/episode statistics for the series.
	public let statistics: SeriesStatisticsResource?
	/// Whether the series' episode list has changed since it was last refreshed.
	public let episodesChanged: Bool?

	/// Creates a series to send to the server.
	/// - Parameters:
	///   - id: Sonarr's internal identifier for the series.
	///   - title: The title of the series.
	///   - alternateTitles: Alternate titles Sonarr matches releases against.
	///   - sortTitle: The title used for sorting.
	///   - status: The airing status of the series.
	///   - ended: Whether the series has finished airing.
	///   - profileName: The name of the quality profile applied to the series.
	///   - overview: A synopsis of the series.
	///   - nextAiring: When the next episode airs, if known.
	///   - previousAiring: When the most recent episode aired, if known.
	///   - network: The broadcast network the series airs on.
	///   - airTime: The local time of day the series airs, e.g. `20:00`.
	///   - images: The artwork associated with the series.
	///   - originalLanguage: The language the series originally aired in.
	///   - remotePoster: A URL to a remotely hosted poster image, used when adding the series.
	///   - seasons: The seasons of the series.
	///   - year: The year the series first aired.
	///   - path: The folder the series' files are stored in.
	///   - qualityProfileId: The identifier of the quality profile applied to the series.
	///   - seasonFolder: Whether each season has its own subfolder under the series folder.
	///   - monitored: Whether the series is monitored for new episodes.
	///   - monitorNewItems: Whether newly added seasons/episodes are monitored.
	///   - useSceneNumbering: Whether Sonarr uses scene numbering to match this series' episodes.
	///   - runtime: The runtime of a typical episode, in minutes.
	///   - tvdbId: The identifier of the series on TheTVDB.
	///   - tvRageId: The identifier of the series on TVRage, if known.
	///   - tvMazeId: The identifier of the series on TVMaze, if known.
	///   - tmdbId: The identifier of the series on TheMovieDB, if known.
	///   - firstAired: When the series first aired.
	///   - lastAired: When the series most recently aired.
	///   - seriesType: The scheduling type of the series.
	///   - cleanTitle: A normalized version of the title used for matching.
	///   - imdbId: The identifier of the series on IMDb, if known.
	///   - titleSlug: A URL-safe version of the title, used to build Sonarr's web UI links.
	///   - rootFolderPath: The root folder the series' folder is stored under.
	///   - folder: The name of the series' folder.
	///   - certification: The content rating of the series, e.g. `TV-14`.
	///   - genres: The genres associated with the series.
	///   - tags: The identifiers of the tags applied to the series.
	///   - added: When the series was added to Sonarr.
	///   - addOptions: Options used when the series was added, or to apply when adding it.
	///   - ratings: The aggregate rating for the series.
	///   - statistics: Aggregate file/episode statistics for the series.
	///   - episodesChanged: Whether the series' episode list has changed since it was last refreshed.
	public init(
		id: Int? = nil,
		title: String? = nil,
		alternateTitles: [AlternateTitleResource]? = nil,
		sortTitle: String? = nil,
		status: SeriesStatusType? = nil,
		ended: Bool? = nil,
		profileName: String? = nil,
		overview: String? = nil,
		nextAiring: Date? = nil,
		previousAiring: Date? = nil,
		network: String? = nil,
		airTime: String? = nil,
		images: [MediaCover]? = nil,
		originalLanguage: Language? = nil,
		remotePoster: String? = nil,
		seasons: [SeasonResource]? = nil,
		year: Int? = nil,
		path: String? = nil,
		qualityProfileId: Int? = nil,
		seasonFolder: Bool? = nil,
		monitored: Bool? = nil,
		monitorNewItems: NewItemMonitorType? = nil,
		useSceneNumbering: Bool? = nil,
		runtime: Int? = nil,
		tvdbId: Int? = nil,
		tvRageId: Int? = nil,
		tvMazeId: Int? = nil,
		tmdbId: Int? = nil,
		firstAired: Date? = nil,
		lastAired: Date? = nil,
		seriesType: SeriesType? = nil,
		cleanTitle: String? = nil,
		imdbId: String? = nil,
		titleSlug: String? = nil,
		rootFolderPath: String? = nil,
		folder: String? = nil,
		certification: String? = nil,
		genres: [String]? = nil,
		tags: [Int]? = nil,
		added: Date? = nil,
		addOptions: AddSeriesOptions? = nil,
		ratings: Ratings? = nil,
		statistics: SeriesStatisticsResource? = nil,
		episodesChanged: Bool? = nil
	) {
		self.id = id
		self.title = title
		self.alternateTitles = alternateTitles
		self.sortTitle = sortTitle
		self.status = status
		self.ended = ended
		self.profileName = profileName
		self.overview = overview
		self.nextAiring = nextAiring
		self.previousAiring = previousAiring
		self.network = network
		self.airTime = airTime
		self.images = images
		self.originalLanguage = originalLanguage
		self.remotePoster = remotePoster
		self.seasons = seasons
		self.year = year
		self.path = path
		self.qualityProfileId = qualityProfileId
		self.seasonFolder = seasonFolder
		self.monitored = monitored
		self.monitorNewItems = monitorNewItems
		self.useSceneNumbering = useSceneNumbering
		self.runtime = runtime
		self.tvdbId = tvdbId
		self.tvRageId = tvRageId
		self.tvMazeId = tvMazeId
		self.tmdbId = tmdbId
		self.firstAired = firstAired
		self.lastAired = lastAired
		self.seriesType = seriesType
		self.cleanTitle = cleanTitle
		self.imdbId = imdbId
		self.titleSlug = titleSlug
		self.rootFolderPath = rootFolderPath
		self.folder = folder
		self.certification = certification
		self.genres = genres
		self.tags = tags
		self.added = added
		self.addOptions = addOptions
		self.ratings = ratings
		self.statistics = statistics
		self.episodesChanged = episodesChanged
	}
}
