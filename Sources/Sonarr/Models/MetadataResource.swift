/// A configured metadata consumer (e.g. Kodi, Roksbox) that Sonarr writes companion files for.
public struct MetadataResource: Equatable, Codable, Sendable {
	/// The unique identifier of this metadata consumer, if it has been saved.
	public let id: Int?
	/// The user-facing name of this metadata consumer.
	public let name: String?
	/// The configurable fields for this metadata consumer's implementation.
	public let fields: [Field]?
	/// The human-readable name of `implementation`.
	public let implementationName: String?
	/// The implementation backing this metadata consumer, e.g. `XbmcMetadata`, `RoksboxMetadata`.
	public let implementation: String?
	/// The name of the settings contract used to configure this metadata consumer.
	public let configContract: String?
	/// A link to further documentation for this metadata consumer's implementation.
	public let infoLink: String?
	/// An informational or warning message from Sonarr about this metadata consumer, if any.
	public let message: ProviderMessage?
	/// The tags that determine which series this metadata consumer applies to.
	public let tags: [Int]?
	/// Preset configurations of this metadata consumer, offered as shortcuts when adding one.
	public let presets: [MetadataResource]?
	/// Whether this metadata consumer is enabled.
	public let enable: Bool

	/// Creates a metadata consumer to send to the server.
	/// - Parameters:
	///   - id: The unique identifier of this metadata consumer, if updating an existing one.
	///   - name: The user-facing name of this metadata consumer.
	///   - fields: The configurable fields for this metadata consumer's implementation.
	///   - implementationName: The human-readable name of `implementation`.
	///   - implementation: The implementation backing this metadata consumer, e.g. `XbmcMetadata`.
	///   - configContract: The name of the settings contract used to configure this metadata consumer.
	///   - infoLink: A link to further documentation for this metadata consumer's implementation.
	///   - message: An informational or warning message from Sonarr about this metadata consumer, if any.
	///   - tags: The tags that determine which series this metadata consumer applies to.
	///   - presets: Preset configurations of this metadata consumer, offered as shortcuts when adding one.
	///   - enable: Whether this metadata consumer is enabled.
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
		presets: [MetadataResource]? = nil,
		enable: Bool
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
	}
}
