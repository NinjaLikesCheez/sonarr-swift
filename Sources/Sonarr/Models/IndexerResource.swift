/// A configured indexer (e.g. a Usenet or torrent tracker) that Sonarr searches and monitors for releases.
public struct IndexerResource: Equatable, Codable, Sendable {
	/// The unique identifier of this indexer, if it has been saved.
	public let id: Int?
	/// The user-facing name of this indexer.
	public let name: String?
	/// The configurable fields for this indexer's implementation.
	public let fields: [Field]?
	/// The human-readable name of `implementation`.
	public let implementationName: String?
	/// The implementation backing this indexer, e.g. `Newznab`, `Torznab`.
	public let implementation: String?
	/// The name of the settings contract used to configure this indexer.
	public let configContract: String?
	/// A link to further documentation for this indexer's implementation.
	public let infoLink: String?
	/// An informational or warning message from Sonarr about this indexer, if any.
	public let message: ProviderMessage?
	/// The tags that determine which series this indexer applies to.
	public let tags: [Int]?
	/// Preset configurations of this indexer, offered as shortcuts when adding one.
	public let presets: [IndexerResource]?
	/// Whether Sonarr grabs releases from this indexer's RSS feed automatically.
	public let enableRss: Bool
	/// Whether Sonarr searches this indexer during automatic searches.
	public let enableAutomaticSearch: Bool
	/// Whether Sonarr searches this indexer during interactive (manual) searches.
	public let enableInteractiveSearch: Bool
	/// Whether this indexer's implementation supports RSS syncing.
	public let supportsRss: Bool
	/// Whether this indexer's implementation supports searching.
	public let supportsSearch: Bool
	/// The download protocol used to fetch releases from this indexer.
	public let `protocol`: DownloadProtocol
	/// The priority of this indexer relative to others; lower values are preferred.
	public let priority: Int
	/// The maximum age, in days, of a single episode for which a season search is still attempted.
	public let seasonSearchMaximumSingleEpisodeAge: Int
	/// The download client releases from this indexer are automatically redirected to.
	public let downloadClientId: Int

	/// Creates an indexer to send to the server.
	/// - Parameters:
	///   - id: The unique identifier of this indexer, if updating an existing one.
	///   - name: The user-facing name of this indexer.
	///   - fields: The configurable fields for this indexer's implementation.
	///   - implementationName: The human-readable name of `implementation`.
	///   - implementation: The implementation backing this indexer, e.g. `Newznab`, `Torznab`.
	///   - configContract: The name of the settings contract used to configure this indexer.
	///   - infoLink: A link to further documentation for this indexer's implementation.
	///   - message: An informational or warning message from Sonarr about this indexer, if any.
	///   - tags: The tags that determine which series this indexer applies to.
	///   - presets: Preset configurations of this indexer, offered as shortcuts when adding one.
	///   - enableRss: Whether Sonarr grabs releases from this indexer's RSS feed automatically.
	///   - enableAutomaticSearch: Whether Sonarr searches this indexer during automatic searches.
	///   - enableInteractiveSearch: Whether Sonarr searches this indexer during interactive (manual) searches.
	///   - supportsRss: Whether this indexer's implementation supports RSS syncing.
	///   - supportsSearch: Whether this indexer's implementation supports searching.
	///   - protocol: The download protocol used to fetch releases from this indexer.
	///   - priority: The priority of this indexer relative to others; lower values are preferred.
	///   - seasonSearchMaximumSingleEpisodeAge: The maximum age, in days, of a single episode for which a season
	///   search is still attempted.
	///   - downloadClientId: The download client releases from this indexer are automatically redirected to.
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
		presets: [IndexerResource]? = nil,
		enableRss: Bool = false,
		enableAutomaticSearch: Bool = false,
		enableInteractiveSearch: Bool = false,
		supportsRss: Bool = false,
		supportsSearch: Bool = false,
		protocol: DownloadProtocol = .unknown,
		priority: Int = 25,
		seasonSearchMaximumSingleEpisodeAge: Int = 0,
		downloadClientId: Int = 0
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
		self.enableRss = enableRss
		self.enableAutomaticSearch = enableAutomaticSearch
		self.enableInteractiveSearch = enableInteractiveSearch
		self.supportsRss = supportsRss
		self.supportsSearch = supportsSearch
		self.protocol = `protocol`
		self.priority = priority
		self.seasonSearchMaximumSingleEpisodeAge = seasonSearchMaximumSingleEpisodeAge
		self.downloadClientId = downloadClientId
	}
}
