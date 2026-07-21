/// A single condition within a custom format, or a schema template describing one.
public struct CustomFormatSpecificationSchema: Equatable, Codable, Sendable {
	/// The unique identifier of this specification, if it has been saved.
	public let id: Int?
	/// The user-facing name of this condition.
	public let name: String?
	/// The implementation backing this condition, e.g. `ReleaseTitleSpecification`.
	public let implementation: String?
	/// The human-readable name of `implementation`.
	public let implementationName: String?
	/// A link to further documentation for this condition's implementation.
	public let infoLink: String?
	/// Whether the condition's result is inverted before being combined.
	public let negate: Bool
	/// Whether this condition must match for the custom format to apply.
	public let required: Bool
	/// The configurable fields for this condition.
	public let fields: [Field]?
	/// Preset configurations of this condition, offered as shortcuts when building a custom format.
	public let presets: [CustomFormatSpecificationSchema]?

	/// Creates a custom format condition to send to the server.
	/// - Parameters:
	///   - id: The unique identifier of this specification, if updating an existing one.
	///   - name: The user-facing name of this condition.
	///   - implementation: The implementation backing this condition, e.g. `ReleaseTitleSpecification`.
	///   - implementationName: The human-readable name of `implementation`.
	///   - infoLink: A link to further documentation for this condition's implementation.
	///   - negate: Whether the condition's result is inverted before being combined.
	///   - required: Whether this condition must match for the custom format to apply.
	///   - fields: The configurable fields for this condition.
	///   - presets: Preset configurations of this condition, offered as shortcuts when building a custom format.
	public init(
		id: Int? = nil,
		name: String?,
		implementation: String?,
		implementationName: String?,
		infoLink: String?,
		negate: Bool,
		required: Bool,
		fields: [Field]?,
		presets: [CustomFormatSpecificationSchema]? = nil
	) {
		self.id = id
		self.name = name
		self.implementation = implementation
		self.implementationName = implementationName
		self.infoLink = infoLink
		self.negate = negate
		self.required = required
		self.fields = fields
		self.presets = presets
	}
}
