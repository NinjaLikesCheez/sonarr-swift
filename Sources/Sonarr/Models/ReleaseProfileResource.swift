/// A profile that flags or rejects releases matching specific terms.
public struct ReleaseProfileResource: Equatable, Codable, Sendable {
	/// The unique identifier of this release profile, if it has been saved.
	public let id: Int?
	/// The user-facing name of this release profile.
	public let name: String?
	/// Whether this release profile is applied.
	public let enabled: Bool?
	/// Terms a release's title must contain to be preferred.
	public let required: [String]?
	/// Terms a release's title must not contain, or it will be rejected.
	public let ignored: [String]?
	/// Restricts this release profile to a single indexer, if non-zero.
	public let indexerId: Int?
	/// The tags that determine which series this release profile applies to.
	public let tags: [Int]?

	/// Creates a release profile to send to the server.
	/// - Parameters:
	///   - id: The unique identifier of this release profile, if updating an existing one.
	///   - name: The user-facing name of this release profile.
	///   - enabled: Whether this release profile is applied.
	///   - required: Terms a release's title must contain to be preferred.
	///   - ignored: Terms a release's title must not contain, or it will be rejected.
	///   - indexerId: Restricts this release profile to a single indexer, if non-zero.
	///   - tags: The tags that determine which series this release profile applies to.
	public init(
		id: Int? = nil,
		name: String? = nil,
		enabled: Bool? = nil,
		required: [String]? = nil,
		ignored: [String]? = nil,
		indexerId: Int? = nil,
		tags: [Int]? = nil
	) {
		self.id = id
		self.name = name
		self.enabled = enabled
		self.required = required
		self.ignored = ignored
		self.indexerId = indexerId
		self.tags = tags
	}
}
