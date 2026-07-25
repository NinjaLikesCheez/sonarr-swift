/// The global episode/folder naming configuration.
public struct NamingConfigResource: Equatable, Codable, Sendable {
	/// The unique identifier of the naming configuration.
	public let id: Int?
	/// Whether Sonarr renames episode files to match the configured formats.
	public let renameEpisodes: Bool?
	/// Whether Sonarr replaces characters that are illegal in file names.
	public let replaceIllegalCharacters: Bool?
	/// The replacement Sonarr uses for colons in file/folder names, as a server-defined ordinal.
	public let colonReplacementFormat: Int?
	/// The custom replacement string used when `colonReplacementFormat` selects a custom replacement.
	public let customColonReplacementFormat: String?
	/// How Sonarr names files containing multiple episodes, as a server-defined ordinal.
	public let multiEpisodeStyle: Int?
	/// The naming format applied to standard (non-daily, non-anime) episode files.
	public let standardEpisodeFormat: String?
	/// The naming format applied to daily episode files.
	public let dailyEpisodeFormat: String?
	/// The naming format applied to anime episode files.
	public let animeEpisodeFormat: String?
	/// The naming format applied to series folders.
	public let seriesFolderFormat: String?
	/// The naming format applied to season folders.
	public let seasonFolderFormat: String?
	/// The naming format applied to the specials folder.
	public let specialsFolderFormat: String?

	/// Creates a naming configuration.
	///
	/// - Parameters:
	///   - id: The unique identifier of the naming configuration.
	///   - renameEpisodes: Whether Sonarr renames episode files to match the configured formats.
	///   - replaceIllegalCharacters: Whether Sonarr replaces characters that are illegal in file names.
	///   - colonReplacementFormat: The replacement Sonarr uses for colons in file/folder names, as a server-defined
	///   ordinal.
	///   - customColonReplacementFormat: The custom replacement string used when `colonReplacementFormat` selects a
	///   custom replacement.
	///   - multiEpisodeStyle: How Sonarr names files containing multiple episodes, as a server-defined ordinal.
	///   - standardEpisodeFormat: The naming format applied to standard (non-daily, non-anime) episode files.
	///   - dailyEpisodeFormat: The naming format applied to daily episode files.
	///   - animeEpisodeFormat: The naming format applied to anime episode files.
	///   - seriesFolderFormat: The naming format applied to series folders.
	///   - seasonFolderFormat: The naming format applied to season folders.
	///   - specialsFolderFormat: The naming format applied to the specials folder.
	public init(
		id: Int? = nil,
		renameEpisodes: Bool? = nil,
		replaceIllegalCharacters: Bool? = nil,
		colonReplacementFormat: Int? = nil,
		customColonReplacementFormat: String? = nil,
		multiEpisodeStyle: Int? = nil,
		standardEpisodeFormat: String? = nil,
		dailyEpisodeFormat: String? = nil,
		animeEpisodeFormat: String? = nil,
		seriesFolderFormat: String? = nil,
		seasonFolderFormat: String? = nil,
		specialsFolderFormat: String? = nil
	) {
		self.id = id
		self.renameEpisodes = renameEpisodes
		self.replaceIllegalCharacters = replaceIllegalCharacters
		self.colonReplacementFormat = colonReplacementFormat
		self.customColonReplacementFormat = customColonReplacementFormat
		self.multiEpisodeStyle = multiEpisodeStyle
		self.standardEpisodeFormat = standardEpisodeFormat
		self.dailyEpisodeFormat = dailyEpisodeFormat
		self.animeEpisodeFormat = animeEpisodeFormat
		self.seriesFolderFormat = seriesFolderFormat
		self.seasonFolderFormat = seasonFolderFormat
		self.specialsFolderFormat = specialsFolderFormat
	}
}
