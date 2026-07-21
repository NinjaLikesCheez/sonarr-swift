/// A configured import list that Sonarr periodically checks for series to add.
public struct ImportListResource: Equatable, Codable, Sendable {
	/// The unique identifier of this import list, if it has been saved.
	public let id: Int?
	/// The user-facing name of this import list.
	public let name: String?
	/// The configurable fields for this import list's implementation.
	public let fields: [Field]?
	/// The human-readable name of `implementation`.
	public let implementationName: String?
	/// The implementation backing this import list, e.g. `PlexImport`, `TraktUserImport`.
	public let implementation: String?
	/// The name of the settings contract used to configure this import list.
	public let configContract: String?
	/// A link to further documentation for this import list's implementation.
	public let infoLink: String?
	/// An informational or warning message from Sonarr about this import list, if any.
	public let message: ProviderMessage?
	/// The tags that determine which series this import list applies to.
	public let tags: [Int]?
	/// Preset configurations of this import list, offered as shortcuts when adding one.
	public let presets: [ImportListResource]?
	/// Whether series found by this import list are automatically added.
	public let enableAutomaticAdd: Bool
	/// Whether Sonarr searches for missing episodes of series added by this import list.
	public let searchForMissingEpisodes: Bool
	/// Which episodes of series added by this import list should be monitored.
	public let shouldMonitor: MonitorType
	/// Whether newly added items from this import list should be monitored.
	public let monitorNewItems: NewItemMonitorType
	/// The root folder new series from this import list are added under.
	public let rootFolderPath: String?
	/// The quality profile assigned to series added by this import list.
	public let qualityProfileId: Int
	/// The series type assigned to series added by this import list.
	public let seriesType: SeriesType
	/// Whether a season folder is created for series added by this import list.
	public let seasonFolder: Bool
	/// The category of source this import list pulls series from.
	public let listType: ImportListType
	/// The order in which this import list is refreshed relative to others.
	public let listOrder: Int
	/// The minimum interval between refreshes of this import list, as a .NET `TimeSpan`-formatted string.
	public let minRefreshInterval: String?

	/// Creates an import list to send to the server.
	/// - Parameters:
	///   - id: The unique identifier of this import list, if updating an existing one.
	///   - name: The user-facing name of this import list.
	///   - fields: The configurable fields for this import list's implementation.
	///   - implementationName: The human-readable name of `implementation`.
	///   - implementation: The implementation backing this import list, e.g. `PlexImport`, `TraktUserImport`.
	///   - configContract: The name of the settings contract used to configure this import list.
	///   - infoLink: A link to further documentation for this import list's implementation.
	///   - message: An informational or warning message from Sonarr about this import list, if any.
	///   - tags: The tags that determine which series this import list applies to.
	///   - presets: Preset configurations of this import list, offered as shortcuts when adding one.
	///   - enableAutomaticAdd: Whether series found by this import list are automatically added.
	///   - searchForMissingEpisodes: Whether Sonarr searches for missing episodes of series added by this import
	///   list.
	///   - shouldMonitor: Which episodes of series added by this import list should be monitored.
	///   - monitorNewItems: Whether newly added items from this import list should be monitored.
	///   - rootFolderPath: The root folder new series from this import list are added under.
	///   - qualityProfileId: The quality profile assigned to series added by this import list.
	///   - seriesType: The series type assigned to series added by this import list.
	///   - seasonFolder: Whether a season folder is created for series added by this import list.
	///   - listType: The category of source this import list pulls series from.
	///   - listOrder: The order in which this import list is refreshed relative to others.
	///   - minRefreshInterval: The minimum interval between refreshes of this import list, as a .NET
	///   `TimeSpan`-formatted string.
	public init(
		id: Int? = nil,
		name: String? = nil,
		fields: [Field]? = nil,
		implementationName: String? = nil,
		implementation: String? = nil,
		configContract: String? = nil,
		infoLink: String? = nil,
		message: ProviderMessage? = nil,
		tags: [Int]? = nil,
		presets: [ImportListResource]? = nil,
		enableAutomaticAdd: Bool,
		searchForMissingEpisodes: Bool,
		shouldMonitor: MonitorType,
		monitorNewItems: NewItemMonitorType,
		rootFolderPath: String? = nil,
		qualityProfileId: Int,
		seriesType: SeriesType,
		seasonFolder: Bool,
		listType: ImportListType,
		listOrder: Int,
		minRefreshInterval: String? = nil
	) {
		self.id = id
		self.name = name
		self.fields = fields
		self.implementationName = implementationName
		self.implementation = implementation
		self.configContract = configContract
		self.infoLink = infoLink
		self.message = message
		self.tags = tags
		self.presets = presets
		self.enableAutomaticAdd = enableAutomaticAdd
		self.searchForMissingEpisodes = searchForMissingEpisodes
		self.shouldMonitor = shouldMonitor
		self.monitorNewItems = monitorNewItems
		self.rootFolderPath = rootFolderPath
		self.qualityProfileId = qualityProfileId
		self.seriesType = seriesType
		self.seasonFolder = seasonFolder
		self.listType = listType
		self.listOrder = listOrder
		self.minRefreshInterval = minRefreshInterval
	}
}
