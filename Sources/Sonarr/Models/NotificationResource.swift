/// A configured notification connection (e.g. Discord, Slack, Webhook) that Sonarr sends events to.
public struct NotificationResource: Equatable, Codable, Sendable {
	/// The unique identifier of this notification, if it has been saved.
	public let id: Int?
	/// The user-facing name of this notification.
	public let name: String?
	/// The configurable fields for this notification's implementation.
	public let fields: [Field]?
	/// The human-readable name of `implementation`.
	public let implementationName: String?
	/// The implementation backing this notification, e.g. `Discord`, `Slack`.
	public let implementation: String?
	/// The name of the settings contract used to configure this notification.
	public let configContract: String?
	/// A link to further documentation for this notification's implementation.
	public let infoLink: String?
	/// An informational or warning message from Sonarr about this notification, if any.
	public let message: ProviderMessage?
	/// The tags that determine which series this notification applies to.
	public let tags: [Int]?
	/// Preset configurations of this notification, offered as shortcuts when adding one.
	public let presets: [NotificationResource]?
	/// A link to the destination this notification sends to, if applicable.
	public let link: String?
	/// Whether this notification fires when a release is grabbed.
	public let onGrab: Bool?
	/// Whether this notification fires when an episode finishes downloading.
	public let onDownload: Bool?
	/// Whether this notification fires when an episode is upgraded to a better quality.
	public let onUpgrade: Bool?
	/// Whether this notification fires when an import completes.
	public let onImportComplete: Bool?
	/// Whether this notification fires when a file is renamed.
	public let onRename: Bool?
	/// Whether this notification fires when a series is added.
	public let onSeriesAdd: Bool?
	/// Whether this notification fires when a series is deleted.
	public let onSeriesDelete: Bool?
	/// Whether this notification fires when an episode file is deleted.
	public let onEpisodeFileDelete: Bool?
	/// Whether this notification fires when an episode file is deleted as part of an upgrade.
	public let onEpisodeFileDeleteForUpgrade: Bool?
	/// Whether this notification fires when a health check issue is detected.
	public let onHealthIssue: Bool?
	/// Whether health warnings (in addition to errors) are included when `onHealthIssue` fires.
	public let includeHealthWarnings: Bool?
	/// Whether this notification fires when a previously reported health issue is resolved.
	public let onHealthRestored: Bool?
	/// Whether this notification fires when Sonarr updates itself.
	public let onApplicationUpdate: Bool?
	/// Whether this notification fires when manual interaction is required to complete an import.
	public let onManualInteractionRequired: Bool?
	/// Whether this implementation supports the `onGrab` event.
	public let supportsOnGrab: Bool?
	/// Whether this implementation supports the `onDownload` event.
	public let supportsOnDownload: Bool?
	/// Whether this implementation supports the `onUpgrade` event.
	public let supportsOnUpgrade: Bool?
	/// Whether this implementation supports the `onImportComplete` event.
	public let supportsOnImportComplete: Bool?
	/// Whether this implementation supports the `onRename` event.
	public let supportsOnRename: Bool?
	/// Whether this implementation supports the `onSeriesAdd` event.
	public let supportsOnSeriesAdd: Bool?
	/// Whether this implementation supports the `onSeriesDelete` event.
	public let supportsOnSeriesDelete: Bool?
	/// Whether this implementation supports the `onEpisodeFileDelete` event.
	public let supportsOnEpisodeFileDelete: Bool?
	/// Whether this implementation supports the `onEpisodeFileDeleteForUpgrade` event.
	public let supportsOnEpisodeFileDeleteForUpgrade: Bool?
	/// Whether this implementation supports the `onHealthIssue` event.
	public let supportsOnHealthIssue: Bool?
	/// Whether this implementation supports the `onHealthRestored` event.
	public let supportsOnHealthRestored: Bool?
	/// Whether this implementation supports the `onApplicationUpdate` event.
	public let supportsOnApplicationUpdate: Bool?
	/// Whether this implementation supports the `onManualInteractionRequired` event.
	public let supportsOnManualInteractionRequired: Bool?
	/// The command Sonarr runs to test this notification's configuration, if applicable.
	public let testCommand: String?

	/// Creates a notification to send to the server.
	/// - Parameters:
	///   - id: The unique identifier of this notification, if updating an existing one.
	///   - name: The user-facing name of this notification.
	///   - fields: The configurable fields for this notification's implementation.
	///   - implementationName: The human-readable name of `implementation`.
	///   - implementation: The implementation backing this notification, e.g. `Discord`, `Slack`.
	///   - configContract: The name of the settings contract used to configure this notification.
	///   - infoLink: A link to further documentation for this notification's implementation.
	///   - message: An informational or warning message from Sonarr about this notification, if any.
	///   - tags: The tags that determine which series this notification applies to.
	///   - presets: Preset configurations of this notification, offered as shortcuts when adding one.
	///   - link: A link to the destination this notification sends to, if applicable.
	///   - onGrab: Whether this notification fires when a release is grabbed.
	///   - onDownload: Whether this notification fires when an episode finishes downloading.
	///   - onUpgrade: Whether this notification fires when an episode is upgraded to a better quality.
	///   - onImportComplete: Whether this notification fires when an import completes.
	///   - onRename: Whether this notification fires when a file is renamed.
	///   - onSeriesAdd: Whether this notification fires when a series is added.
	///   - onSeriesDelete: Whether this notification fires when a series is deleted.
	///   - onEpisodeFileDelete: Whether this notification fires when an episode file is deleted.
	///   - onEpisodeFileDeleteForUpgrade: Whether this notification fires when an episode file is deleted as part of
	///   an upgrade.
	///   - onHealthIssue: Whether this notification fires when a health check issue is detected.
	///   - includeHealthWarnings: Whether health warnings (in addition to errors) are included when `onHealthIssue`
	///   fires.
	///   - onHealthRestored: Whether this notification fires when a previously reported health issue is resolved.
	///   - onApplicationUpdate: Whether this notification fires when Sonarr updates itself.
	///   - onManualInteractionRequired: Whether this notification fires when manual interaction is required to
	///   complete an import.
	///   - supportsOnGrab: Whether this implementation supports the `onGrab` event.
	///   - supportsOnDownload: Whether this implementation supports the `onDownload` event.
	///   - supportsOnUpgrade: Whether this implementation supports the `onUpgrade` event.
	///   - supportsOnImportComplete: Whether this implementation supports the `onImportComplete` event.
	///   - supportsOnRename: Whether this implementation supports the `onRename` event.
	///   - supportsOnSeriesAdd: Whether this implementation supports the `onSeriesAdd` event.
	///   - supportsOnSeriesDelete: Whether this implementation supports the `onSeriesDelete` event.
	///   - supportsOnEpisodeFileDelete: Whether this implementation supports the `onEpisodeFileDelete` event.
	///   - supportsOnEpisodeFileDeleteForUpgrade: Whether this implementation supports the
	///   `onEpisodeFileDeleteForUpgrade` event.
	///   - supportsOnHealthIssue: Whether this implementation supports the `onHealthIssue` event.
	///   - supportsOnHealthRestored: Whether this implementation supports the `onHealthRestored` event.
	///   - supportsOnApplicationUpdate: Whether this implementation supports the `onApplicationUpdate` event.
	///   - supportsOnManualInteractionRequired: Whether this implementation supports the
	///   `onManualInteractionRequired` event.
	///   - testCommand: The command Sonarr runs to test this notification's configuration, if applicable.
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
		presets: [NotificationResource]? = nil,
		link: String? = nil,
		onGrab: Bool? = nil,
		onDownload: Bool? = nil,
		onUpgrade: Bool? = nil,
		onImportComplete: Bool? = nil,
		onRename: Bool? = nil,
		onSeriesAdd: Bool? = nil,
		onSeriesDelete: Bool? = nil,
		onEpisodeFileDelete: Bool? = nil,
		onEpisodeFileDeleteForUpgrade: Bool? = nil,
		onHealthIssue: Bool? = nil,
		includeHealthWarnings: Bool? = nil,
		onHealthRestored: Bool? = nil,
		onApplicationUpdate: Bool? = nil,
		onManualInteractionRequired: Bool? = nil,
		supportsOnGrab: Bool? = nil,
		supportsOnDownload: Bool? = nil,
		supportsOnUpgrade: Bool? = nil,
		supportsOnImportComplete: Bool? = nil,
		supportsOnRename: Bool? = nil,
		supportsOnSeriesAdd: Bool? = nil,
		supportsOnSeriesDelete: Bool? = nil,
		supportsOnEpisodeFileDelete: Bool? = nil,
		supportsOnEpisodeFileDeleteForUpgrade: Bool? = nil,
		supportsOnHealthIssue: Bool? = nil,
		supportsOnHealthRestored: Bool? = nil,
		supportsOnApplicationUpdate: Bool? = nil,
		supportsOnManualInteractionRequired: Bool? = nil,
		testCommand: String? = nil
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
		self.link = link
		self.onGrab = onGrab
		self.onDownload = onDownload
		self.onUpgrade = onUpgrade
		self.onImportComplete = onImportComplete
		self.onRename = onRename
		self.onSeriesAdd = onSeriesAdd
		self.onSeriesDelete = onSeriesDelete
		self.onEpisodeFileDelete = onEpisodeFileDelete
		self.onEpisodeFileDeleteForUpgrade = onEpisodeFileDeleteForUpgrade
		self.onHealthIssue = onHealthIssue
		self.includeHealthWarnings = includeHealthWarnings
		self.onHealthRestored = onHealthRestored
		self.onApplicationUpdate = onApplicationUpdate
		self.onManualInteractionRequired = onManualInteractionRequired
		self.supportsOnGrab = supportsOnGrab
		self.supportsOnDownload = supportsOnDownload
		self.supportsOnUpgrade = supportsOnUpgrade
		self.supportsOnImportComplete = supportsOnImportComplete
		self.supportsOnRename = supportsOnRename
		self.supportsOnSeriesAdd = supportsOnSeriesAdd
		self.supportsOnSeriesDelete = supportsOnSeriesDelete
		self.supportsOnEpisodeFileDelete = supportsOnEpisodeFileDelete
		self.supportsOnEpisodeFileDeleteForUpgrade = supportsOnEpisodeFileDeleteForUpgrade
		self.supportsOnHealthIssue = supportsOnHealthIssue
		self.supportsOnHealthRestored = supportsOnHealthRestored
		self.supportsOnApplicationUpdate = supportsOnApplicationUpdate
		self.supportsOnManualInteractionRequired = supportsOnManualInteractionRequired
		self.testCommand = testCommand
	}
}
