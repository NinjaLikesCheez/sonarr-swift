/// The request body for bulk-removing blocklist entries.
public struct BlocklistBulkResource: Equatable, Encodable, Sendable {
	/// The identifiers of the blocklist entries to remove.
	public let ids: [Int]

	/// Creates a bulk removal request for the given blocklist entry identifiers.
	/// - Parameter ids: The identifiers of the blocklist entries to remove.
	public init(ids: [Int]) {
		self.ids = ids
	}
}
