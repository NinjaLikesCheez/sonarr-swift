/// A saved custom format used to score and prefer releases matching specific conditions.
public struct CustomFormatResource: Equatable, Codable, Sendable {
	/// The unique identifier of this custom format, if it has been saved.
	public let id: Int?
	/// The user-facing name of this custom format.
	public let name: String?
	/// Whether this custom format's name is appended to the file when renaming.
	public let includeCustomFormatWhenRenaming: Bool?
	/// The conditions that must be satisfied for this custom format to apply.
	public let specifications: [CustomFormatSpecificationSchema]?

	/// Creates a custom format to send to the server.
	/// - Parameters:
	///   - id: The unique identifier of this custom format, if updating an existing one.
	///   - name: The user-facing name of this custom format.
	///   - includeCustomFormatWhenRenaming: Whether this custom format's name is appended to the file when renaming.
	///   - specifications: The conditions that must be satisfied for this custom format to apply.
	public init(
		id: Int? = nil,
		name: String?,
		includeCustomFormatWhenRenaming: Bool?,
		specifications: [CustomFormatSpecificationSchema]?
	) {
		self.id = id
		self.name = name
		self.includeCustomFormatWhenRenaming = includeCustomFormatWhenRenaming
		self.specifications = specifications
	}
}
