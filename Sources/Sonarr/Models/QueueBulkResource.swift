/// The request body for bulk-removing queue items.
public struct QueueBulkResource: Equatable, Encodable, Sendable {
	/// The identifiers of the queue items to remove.
	public let ids: [Int]

	/// Creates a bulk removal request for the given queue item identifiers.
	/// - Parameter ids: The identifiers of the queue items to remove.
	public init(ids: [Int]) {
		self.ids = ids
	}
}
