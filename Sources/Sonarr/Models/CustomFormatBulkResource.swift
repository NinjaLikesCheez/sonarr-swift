/// The request body for bulk-updating or bulk-removing custom formats.
public struct CustomFormatBulkResource: Equatable, Encodable, Sendable {
	/// The identifiers of the custom formats to update or remove.
	public let ids: [Int]
	/// Whether the affected custom formats' names are appended to the file when renaming.
	public let includeCustomFormatWhenRenaming: Bool?

	/// Creates a bulk request for the given custom format identifiers.
	/// - Parameters:
	///   - ids: The identifiers of the custom formats to update or remove.
	///   - includeCustomFormatWhenRenaming: Whether the affected custom formats' names are appended to the file
	///   when renaming.
	public init(ids: [Int], includeCustomFormatWhenRenaming: Bool? = nil) {
		self.ids = ids
		self.includeCustomFormatWhenRenaming = includeCustomFormatWhenRenaming
	}
}
