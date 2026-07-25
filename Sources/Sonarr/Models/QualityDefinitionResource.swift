/// The size limits and preferences Sonarr applies to releases of a given quality.
public struct QualityDefinitionResource: Equatable, Codable, Sendable {
	/// The unique identifier of this quality definition.
	public let id: Int?
	/// The quality this definition applies to.
	public let quality: Quality?
	/// The user-facing title of this quality definition.
	public let title: String?
	/// The weight used to rank this quality against others.
	public let weight: Int?
	/// The minimum acceptable size, in megabytes per minute of runtime.
	public let minSize: Double?
	/// The maximum acceptable size, in megabytes per minute of runtime.
	public let maxSize: Double?
	/// The preferred size, in megabytes per minute of runtime.
	public let preferredSize: Double?

	/// Creates a quality definition.
	/// - Parameters:
	///   - id: The unique identifier of this quality definition.
	///   - quality: The quality this definition applies to.
	///   - title: The user-facing title of this quality definition.
	///   - weight: The weight used to rank this quality against others.
	///   - minSize: The minimum acceptable size, in megabytes per minute of runtime.
	///   - maxSize: The maximum acceptable size, in megabytes per minute of runtime.
	///   - preferredSize: The preferred size, in megabytes per minute of runtime.
	public init(
		id: Int? = nil,
		quality: Quality? = nil,
		title: String? = nil,
		weight: Int? = nil,
		minSize: Double? = nil,
		maxSize: Double? = nil,
		preferredSize: Double? = nil
	) {
		self.id = id
		self.quality = quality
		self.title = title
		self.weight = weight
		self.minSize = minSize
		self.maxSize = maxSize
		self.preferredSize = preferredSize
	}
}
