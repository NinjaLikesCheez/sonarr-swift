/// A configured download client (e.g. SABnzbd, qBittorrent) that Sonarr sends releases to.
public struct DownloadClientResource: Equatable, Codable, Sendable {
	/// The unique identifier of this download client, if it has been saved.
	public let id: Int?
	/// The user-facing name of this download client.
	public let name: String?
	/// The configurable fields for this download client's implementation.
	public let fields: [Field]?
	/// The human-readable name of `implementation`.
	public let implementationName: String?
	/// The implementation backing this download client, e.g. `Sabnzbd`, `QBittorrent`.
	public let implementation: String?
	/// The name of the settings contract used to configure this download client.
	public let configContract: String?
	/// A link to further documentation for this download client's implementation.
	public let infoLink: String?
	/// An informational or warning message from Sonarr about this download client, if any.
	public let message: ProviderMessage?
	/// The tags that determine which series this download client applies to.
	public let tags: [Int]?
	/// Preset configurations of this download client, offered as shortcuts when adding one.
	public let presets: [DownloadClientResource]?
	/// Whether this download client is enabled.
	public let enable: Bool
	/// The protocol this download client handles, e.g. Usenet or torrent.
	public let `protocol`: DownloadProtocol
	/// The order in which this download client is checked relative to others of the same protocol.
	public let priority: Int
	/// Whether completed downloads are removed from the download client after import.
	public let removeCompletedDownloads: Bool
	/// Whether failed downloads are removed from the download client.
	public let removeFailedDownloads: Bool

	/// Creates a download client to send to the server.
	/// - Parameters:
	///   - id: The unique identifier of this download client, if updating an existing one.
	///   - name: The user-facing name of this download client.
	///   - fields: The configurable fields for this download client's implementation.
	///   - implementationName: The human-readable name of `implementation`.
	///   - implementation: The implementation backing this download client, e.g. `Sabnzbd`, `QBittorrent`.
	///   - configContract: The name of the settings contract used to configure this download client.
	///   - infoLink: A link to further documentation for this download client's implementation.
	///   - message: An informational or warning message from Sonarr about this download client, if any.
	///   - tags: The tags that determine which series this download client applies to.
	///   - presets: Preset configurations of this download client, offered as shortcuts when adding one.
	///   - enable: Whether this download client is enabled.
	///   - protocol: The protocol this download client handles, e.g. Usenet or torrent.
	///   - priority: The order in which this download client is checked relative to others of the same protocol.
	///   - removeCompletedDownloads: Whether completed downloads are removed from the download client after import.
	///   - removeFailedDownloads: Whether failed downloads are removed from the download client.
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
		presets: [DownloadClientResource]? = nil,
		enable: Bool,
		protocol: DownloadProtocol,
		priority: Int,
		removeCompletedDownloads: Bool,
		removeFailedDownloads: Bool
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
		self.enable = enable
		self.protocol = `protocol`
		self.priority = priority
		self.removeCompletedDownloads = removeCompletedDownloads
		self.removeFailedDownloads = removeFailedDownloads
	}
}
