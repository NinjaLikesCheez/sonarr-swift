/// Example file/folder names produced by a set of naming configuration formats.
public struct NamingConfigExamplesResource: Equatable, Decodable, Sendable {
	/// An example file name for a standard single-episode release.
	public let singleEpisodeExample: String?
	/// An example file name for a release spanning multiple episodes.
	public let multiEpisodeExample: String?
	/// An example file name for a daily episode release.
	public let dailyEpisodeExample: String?
	/// An example file name for an anime episode release.
	public let animeEpisodeExample: String?
	/// An example file name for an anime release spanning multiple episodes.
	public let animeMultiEpisodeExample: String?
	/// An example series folder name.
	public let seriesFolderExample: String?
	/// An example season folder name.
	public let seasonFolderExample: String?
	/// An example specials folder name.
	public let specialsFolderExample: String?
}
