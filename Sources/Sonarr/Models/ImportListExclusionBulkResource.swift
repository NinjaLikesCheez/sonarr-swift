/// The request body for bulk-removing import list exclusions.
public struct ImportListExclusionBulkResource: Equatable, Encodable, Sendable {
	/// The identifiers of the import list exclusions to remove.
	public let ids: [Int]?

	/// Creates a bulk removal request for the given import list exclusion identifiers.
	/// - Parameter ids: The identifiers of the import list exclusions to remove.
	public init(ids: [Int]? = nil) {
		self.ids = ids
	}
}
