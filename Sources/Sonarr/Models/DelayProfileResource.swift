/// A profile that delays grabbing releases of a given protocol to allow better releases to appear.
public struct DelayProfileResource: Equatable, Codable, Sendable {
	/// The unique identifier of this delay profile, if it has been saved.
	public let id: Int?
	/// Whether Usenet releases are allowed.
	public let enableUsenet: Bool?
	/// Whether torrent releases are allowed.
	public let enableTorrent: Bool?
	/// The protocol preferred when both Usenet and torrent releases are available.
	public let preferredProtocol: DownloadProtocol?
	/// The number of minutes to delay grabbing a Usenet release.
	public let usenetDelay: Int?
	/// The number of minutes to delay grabbing a torrent release.
	public let torrentDelay: Int?
	/// Whether the delay is bypassed if a release is already the highest quality in the quality profile's cutoff.
	public let bypassIfHighestQuality: Bool?
	/// Whether the delay is bypassed if a release's custom format score is above `minimumCustomFormatScore`.
	public let bypassIfAboveCustomFormatScore: Bool?
	/// The minimum custom format score a release must have for `bypassIfAboveCustomFormatScore` to apply.
	public let minimumCustomFormatScore: Int?
	/// The position of this profile relative to other delay profiles; lower values are evaluated first.
	public let order: Int?
	/// The tags that determine which series this delay profile applies to.
	public let tags: [Int]?

	/// Creates a delay profile to send to the server.
	/// - Parameters:
	///   - id: The unique identifier of this delay profile, if updating an existing one.
	///   - enableUsenet: Whether Usenet releases are allowed.
	///   - enableTorrent: Whether torrent releases are allowed.
	///   - preferredProtocol: The protocol preferred when both Usenet and torrent releases are available.
	///   - usenetDelay: The number of minutes to delay grabbing a Usenet release.
	///   - torrentDelay: The number of minutes to delay grabbing a torrent release.
	///   - bypassIfHighestQuality: Whether the delay is bypassed if a release is already the highest quality in the
	///   quality profile's cutoff.
	///   - bypassIfAboveCustomFormatScore: Whether the delay is bypassed if a release's custom format score is above
	///   `minimumCustomFormatScore`.
	///   - minimumCustomFormatScore: The minimum custom format score a release must have for
	///   `bypassIfAboveCustomFormatScore` to apply.
	///   - order: The position of this profile relative to other delay profiles; lower values are evaluated first.
	///   - tags: The tags that determine which series this delay profile applies to.
	public init(
		id: Int? = nil,
		enableUsenet: Bool? = nil,
		enableTorrent: Bool? = nil,
		preferredProtocol: DownloadProtocol? = nil,
		usenetDelay: Int? = nil,
		torrentDelay: Int? = nil,
		bypassIfHighestQuality: Bool? = nil,
		bypassIfAboveCustomFormatScore: Bool? = nil,
		minimumCustomFormatScore: Int? = nil,
		order: Int? = nil,
		tags: [Int]? = nil
	) {
		self.id = id
		self.enableUsenet = enableUsenet
		self.enableTorrent = enableTorrent
		self.preferredProtocol = preferredProtocol
		self.usenetDelay = usenetDelay
		self.torrentDelay = torrentDelay
		self.bypassIfHighestQuality = bypassIfHighestQuality
		self.bypassIfAboveCustomFormatScore = bypassIfAboveCustomFormatScore
		self.minimumCustomFormatScore = minimumCustomFormatScore
		self.order = order
		self.tags = tags
	}
}
