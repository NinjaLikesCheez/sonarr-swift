/// A single condition within an auto-tagging definition, or a schema template describing one.
public struct AutoTaggingSpecificationSchema: Equatable, Codable, Sendable {
	/// The unique identifier of this specification, if it has been saved.
	public let id: Int?
	/// The user-facing name of this condition.
	public let name: String?
	/// The implementation backing this condition, e.g. `SeriesTypeSpecification`.
	public let implementation: String?
	/// The human-readable name of `implementation`.
	public let implementationName: String?
	/// Whether the condition's result is inverted before being combined.
	public let negate: Bool
	/// Whether this condition must match for the auto-tag to apply.
	public let required: Bool
	/// The configurable fields for this condition.
	public let fields: [Field]?

	/// Creates an auto-tagging condition to send to the server.
	/// - Parameters:
	///   - id: The unique identifier of this specification, if updating an existing one.
	///   - name: The user-facing name of this condition.
	///   - implementation: The implementation backing this condition, e.g. `SeriesTypeSpecification`.
	///   - implementationName: The human-readable name of `implementation`.
	///   - negate: Whether the condition's result is inverted before being combined.
	///   - required: Whether this condition must match for the auto-tag to apply.
	///   - fields: The configurable fields for this condition.
	public init(
		id: Int? = nil,
		name: String?,
		implementation: String?,
		implementationName: String?,
		negate: Bool,
		required: Bool,
		fields: [Field]?
	) {
		self.id = id
		self.name = name
		self.implementation = implementation
		self.implementationName = implementationName
		self.negate = negate
		self.required = required
		self.fields = fields
	}
}
