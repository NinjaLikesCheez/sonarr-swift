/// A saved auto-tagging definition: a set of conditions that automatically apply tags to matching series.
public struct AutoTaggingResource: Equatable, Codable, Sendable {
	/// The unique identifier of this auto-tag, if it has been saved.
	public let id: Int?
	/// The user-facing name of this auto-tag.
	public let name: String?
	/// Whether tags applied by this auto-tag are removed automatically once it no longer matches.
	public let removeTagsAutomatically: Bool
	/// The IDs of the tags applied when this auto-tag's conditions match.
	public let tags: [Int]?
	/// The conditions that must match for this auto-tag to apply.
	public let specifications: [AutoTaggingSpecificationSchema]?

	/// Creates an auto-tagging definition to send to the server.
	/// - Parameters:
	///   - id: The unique identifier of this auto-tag, if updating an existing one.
	///   - name: The user-facing name of this auto-tag.
	///   - removeTagsAutomatically: Whether applied tags are removed automatically once conditions no longer match.
	///   - tags: The IDs of the tags applied when this auto-tag's conditions match.
	///   - specifications: The conditions that must match for this auto-tag to apply.
	public init(
		id: Int? = nil,
		name: String?,
		removeTagsAutomatically: Bool,
		tags: [Int]?,
		specifications: [AutoTaggingSpecificationSchema]?
	) {
		self.id = id
		self.name = name
		self.removeTagsAutomatically = removeTagsAutomatically
		self.tags = tags
		self.specifications = specifications
	}
}
