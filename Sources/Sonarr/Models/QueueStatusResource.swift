/// A summary of the download queue's overall health.
public struct QueueStatusResource: Equatable, Decodable, Sendable {
	// Sonarr's live API omits `id` from this endpoint's response despite the OpenAPI spec
	// declaring it non-nullable, since this resource isn't backed by a persisted record.
	/// Sonarr's internal identifier for this status snapshot, if any.
	public let id: Int?
	/// The total number of items in the queue.
	public let totalCount: Int
	/// The number of items counted towards the queue badge.
	public let count: Int
	/// The number of items not associated with a known series.
	public let unknownCount: Int
	/// Whether any queue item has an error.
	public let errors: Bool
	/// Whether any queue item has a warning.
	public let warnings: Bool
	/// Whether any item not associated with a known series has an error.
	public let unknownErrors: Bool
	/// Whether any item not associated with a known series has a warning.
	public let unknownWarnings: Bool
}
