/// The global media management configuration.
public struct MediaManagementConfigResource: Equatable, Codable, Sendable {
	/// The unique identifier of the media management configuration.
	public let id: Int?
	/// Whether Sonarr automatically unmonitors episodes once a file has been downloaded and deleted.
	public let autoUnmonitorPreviouslyDownloadedEpisodes: Bool?
	/// The folder replaced files are moved to instead of being permanently deleted.
	public let recycleBin: String?
	/// The number of days files are kept in the recycle bin before being permanently deleted.
	public let recycleBinCleanupDays: Int?
	/// How Sonarr handles proper/repack releases of episodes it already has.
	public let downloadPropersAndRepacks: ProperDownloadTypes?
	/// Whether Sonarr creates a folder for every series, even if it has no files.
	public let createEmptySeriesFolders: Bool?
	/// Whether Sonarr deletes empty series/season folders during disk scans.
	public let deleteEmptyFolders: Bool?
	/// The source used to set an imported episode file's modified date.
	public let fileDate: FileDateType?
	/// When Sonarr rescans a series' folder after refreshing it.
	public let rescanAfterRefresh: RescanAfterRefreshType?
	/// Whether Sonarr sets file/folder permissions (chmod/chown) after importing, on Linux.
	public let setPermissionsLinux: Bool?
	/// The octal permissions applied to folders when `setPermissionsLinux` is enabled.
	public let chmodFolder: String?
	/// The group ownership applied to files/folders when `setPermissionsLinux` is enabled.
	public let chownGroup: String?
	/// When Sonarr requires an episode title before importing a file.
	public let episodeTitleRequired: EpisodeTitleRequiredType?
	/// Whether Sonarr skips the free disk space check when importing.
	public let skipFreeSpaceCheckWhenImporting: Bool?
	/// The minimum free disk space, in megabytes, required to import a file.
	public let minimumFreeSpaceWhenImporting: Int?
	/// Whether Sonarr uses hardlinks instead of copying files when importing.
	public let copyUsingHardlinks: Bool?
	/// Whether Sonarr runs a custom script after importing a file, instead of its built-in import logic.
	public let useScriptImport: Bool?
	/// The path to the custom import script, used when `useScriptImport` is enabled.
	public let scriptImportPath: String?
	/// Whether Sonarr imports non-video files (e.g. subtitles, `.nfo`) alongside episode files.
	public let importExtraFiles: Bool?
	/// A comma-separated list of file extensions to import when `importExtraFiles` is enabled.
	public let extraFileExtensions: String?
	/// Whether Sonarr extracts and stores media info (codec, resolution, etc.) from imported files.
	public let enableMediaInfo: Bool?

	/// Creates a media management configuration.
	///
	/// - Parameters:
	///   - id: The unique identifier of the media management configuration.
	///   - autoUnmonitorPreviouslyDownloadedEpisodes: Whether Sonarr automatically unmonitors episodes once a file
	///   has been downloaded and deleted.
	///   - recycleBin: The folder replaced files are moved to instead of being permanently deleted.
	///   - recycleBinCleanupDays: The number of days files are kept in the recycle bin before being permanently
	///   deleted.
	///   - downloadPropersAndRepacks: How Sonarr handles proper/repack releases of episodes it already has.
	///   - createEmptySeriesFolders: Whether Sonarr creates a folder for every series, even if it has no files.
	///   - deleteEmptyFolders: Whether Sonarr deletes empty series/season folders during disk scans.
	///   - fileDate: The source used to set an imported episode file's modified date.
	///   - rescanAfterRefresh: When Sonarr rescans a series' folder after refreshing it.
	///   - setPermissionsLinux: Whether Sonarr sets file/folder permissions (chmod/chown) after importing, on Linux.
	///   - chmodFolder: The octal permissions applied to folders when `setPermissionsLinux` is enabled.
	///   - chownGroup: The group ownership applied to files/folders when `setPermissionsLinux` is enabled.
	///   - episodeTitleRequired: When Sonarr requires an episode title before importing a file.
	///   - skipFreeSpaceCheckWhenImporting: Whether Sonarr skips the free disk space check when importing.
	///   - minimumFreeSpaceWhenImporting: The minimum free disk space, in megabytes, required to import a file.
	///   - copyUsingHardlinks: Whether Sonarr uses hardlinks instead of copying files when importing.
	///   - useScriptImport: Whether Sonarr runs a custom script after importing a file, instead of its built-in
	///   import logic.
	///   - scriptImportPath: The path to the custom import script, used when `useScriptImport` is enabled.
	///   - importExtraFiles: Whether Sonarr imports non-video files (e.g. subtitles, `.nfo`) alongside episode files.
	///   - extraFileExtensions: A comma-separated list of file extensions to import when `importExtraFiles` is
	///   enabled.
	///   - enableMediaInfo: Whether Sonarr extracts and stores media info (codec, resolution, etc.) from imported
	///   files.
	public init(
		id: Int? = nil,
		autoUnmonitorPreviouslyDownloadedEpisodes: Bool? = nil,
		recycleBin: String? = nil,
		recycleBinCleanupDays: Int? = nil,
		downloadPropersAndRepacks: ProperDownloadTypes? = nil,
		createEmptySeriesFolders: Bool? = nil,
		deleteEmptyFolders: Bool? = nil,
		fileDate: FileDateType? = nil,
		rescanAfterRefresh: RescanAfterRefreshType? = nil,
		setPermissionsLinux: Bool? = nil,
		chmodFolder: String? = nil,
		chownGroup: String? = nil,
		episodeTitleRequired: EpisodeTitleRequiredType? = nil,
		skipFreeSpaceCheckWhenImporting: Bool? = nil,
		minimumFreeSpaceWhenImporting: Int? = nil,
		copyUsingHardlinks: Bool? = nil,
		useScriptImport: Bool? = nil,
		scriptImportPath: String? = nil,
		importExtraFiles: Bool? = nil,
		extraFileExtensions: String? = nil,
		enableMediaInfo: Bool? = nil
	) {
		self.id = id
		self.autoUnmonitorPreviouslyDownloadedEpisodes = autoUnmonitorPreviouslyDownloadedEpisodes
		self.recycleBin = recycleBin
		self.recycleBinCleanupDays = recycleBinCleanupDays
		self.downloadPropersAndRepacks = downloadPropersAndRepacks
		self.createEmptySeriesFolders = createEmptySeriesFolders
		self.deleteEmptyFolders = deleteEmptyFolders
		self.fileDate = fileDate
		self.rescanAfterRefresh = rescanAfterRefresh
		self.setPermissionsLinux = setPermissionsLinux
		self.chmodFolder = chmodFolder
		self.chownGroup = chownGroup
		self.episodeTitleRequired = episodeTitleRequired
		self.skipFreeSpaceCheckWhenImporting = skipFreeSpaceCheckWhenImporting
		self.minimumFreeSpaceWhenImporting = minimumFreeSpaceWhenImporting
		self.copyUsingHardlinks = copyUsingHardlinks
		self.useScriptImport = useScriptImport
		self.scriptImportPath = scriptImportPath
		self.importExtraFiles = importExtraFiles
		self.extraFileExtensions = extraFileExtensions
		self.enableMediaInfo = enableMediaInfo
	}
}
