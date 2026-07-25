/// A single entry in a quality profile's quality/group tree.
///
/// A quality profile's `items` form a tree: top-level entries are either a single quality (`quality` set,
/// `items` empty) or a named group of qualities treated as equivalent (`name` set, `items` populated with the
/// group's member qualities). Sonarr only nests one level deep in practice, but the wire format allows
/// `items` to recurse.
public struct QualityProfileQualityItemResource: Equatable, Codable, Sendable {
	/// The unique identifier of this entry.
	public let id: Int?
	/// The name of this entry, if it represents a named group of qualities.
	public let name: String?
	/// The quality this entry represents, if it's a single quality rather than a group.
	public let quality: Quality?
	/// The qualities nested under this entry, if it represents a group.
	public let items: [QualityProfileQualityItemResource]?
	/// Whether this quality (or group) is allowed by the profile.
	public let allowed: Bool?
	/// The minimum acceptable size, in megabytes per minute of runtime.
	public let minSize: Double?
	/// The maximum acceptable size, in megabytes per minute of runtime.
	public let maxSize: Double?
	/// The preferred size, in megabytes per minute of runtime.
	public let preferredSize: Double?

	/// Creates a quality profile quality/group entry.
	/// - Parameters:
	///   - id: The unique identifier of this entry.
	///   - name: The name of this entry, if it represents a named group of qualities.
	///   - quality: The quality this entry represents, if it's a single quality rather than a group.
	///   - items: The qualities nested under this entry, if it represents a group.
	///   - allowed: Whether this quality (or group) is allowed by the profile.
	///   - minSize: The minimum acceptable size, in megabytes per minute of runtime.
	///   - maxSize: The maximum acceptable size, in megabytes per minute of runtime.
	///   - preferredSize: The preferred size, in megabytes per minute of runtime.
	public init(
		id: Int? = nil,
		name: String? = nil,
		quality: Quality? = nil,
		items: [QualityProfileQualityItemResource]? = nil,
		allowed: Bool? = nil,
		minSize: Double? = nil,
		maxSize: Double? = nil,
		preferredSize: Double? = nil
	) {
		self.id = id
		self.name = name
		self.quality = quality
		self.items = items
		self.allowed = allowed
		self.minSize = minSize
		self.maxSize = maxSize
		self.preferredSize = preferredSize
	}
}
