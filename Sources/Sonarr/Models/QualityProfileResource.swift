/// A quality profile, ranking qualities by preference and scoring custom formats for a series.
public struct QualityProfileResource: Equatable, Codable, Sendable {
	/// The unique identifier of the quality profile.
	public let id: Int?
	/// The user-facing name of the quality profile.
	public let name: String?
	/// Whether Sonarr is allowed to upgrade an episode's quality once the cutoff is met.
	public let upgradeAllowed: Bool?
	/// The identifier of the quality (or group) at which Sonarr stops upgrading an episode's quality.
	public let cutoff: Int?
	/// The ranked tree of qualities and quality groups allowed by this profile.
	public let items: [QualityProfileQualityItemResource]?
	/// The minimum total custom format score a release must have to be grabbed.
	public let minFormatScore: Int?
	/// The custom format score at which Sonarr stops upgrading a release.
	public let cutoffFormatScore: Int?
	/// The minimum custom format score improvement required for a release to be considered an upgrade.
	public let minUpgradeFormatScore: Int?
	/// The custom format scores this profile assigns.
	public let formatItems: [ProfileFormatItemResource]?

	/// Creates a quality profile.
	///
	/// - Parameters:
	///   - id: The unique identifier of the quality profile.
	///   - name: The user-facing name of the quality profile.
	///   - upgradeAllowed: Whether Sonarr is allowed to upgrade an episode's quality once the cutoff is met.
	///   - cutoff: The identifier of the quality (or group) at which Sonarr stops upgrading an episode's quality.
	///   - items: The ranked tree of qualities and quality groups allowed by this profile.
	///   - minFormatScore: The minimum total custom format score a release must have to be grabbed.
	///   - cutoffFormatScore: The custom format score at which Sonarr stops upgrading a release.
	///   - minUpgradeFormatScore: The minimum custom format score improvement required for a release to be
	///   considered an upgrade.
	///   - formatItems: The custom format scores this profile assigns.
	public init(
		id: Int? = nil,
		name: String? = nil,
		upgradeAllowed: Bool? = nil,
		cutoff: Int? = nil,
		items: [QualityProfileQualityItemResource]? = nil,
		minFormatScore: Int? = nil,
		cutoffFormatScore: Int? = nil,
		minUpgradeFormatScore: Int? = nil,
		formatItems: [ProfileFormatItemResource]? = nil
	) {
		self.id = id
		self.name = name
		self.upgradeAllowed = upgradeAllowed
		self.cutoff = cutoff
		self.items = items
		self.minFormatScore = minFormatScore
		self.cutoffFormatScore = cutoffFormatScore
		self.minUpgradeFormatScore = minUpgradeFormatScore
		self.formatItems = formatItems
	}
}
