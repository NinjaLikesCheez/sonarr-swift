/// The result of parsing a release title or file path for episode/series information.
public struct ParseResource: Equatable, Decodable, Sendable {
	/// The unique identifier of this parse result.
	public let id: Int?
	/// The title that was parsed.
	public let title: String?
	/// The episode/series information Sonarr parsed out of the title.
	public let parsedEpisodeInfo: ParsedEpisodeInfo?
	/// The series Sonarr matched the parsed title to, if any.
	public let series: SeriesResource?
	/// The episodes Sonarr matched the parsed title to, if any.
	public let episodes: [EpisodeResource]?
	/// The languages Sonarr matched for the parsed title.
	public let languages: [Language]?
	/// The custom formats Sonarr matched for the parsed title.
	public let customFormats: [CustomFormatResource]?
	/// The total score Sonarr assigned across all matched custom formats.
	public let customFormatScore: Int?
}
