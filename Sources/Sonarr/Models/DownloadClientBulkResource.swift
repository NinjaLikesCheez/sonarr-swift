/// The request body for bulk-updating or bulk-removing download clients.
public struct DownloadClientBulkResource: Equatable, Encodable, Sendable {
	/// The identifiers of the download clients to update or remove.
	public let ids: [Int]?
	/// The tags to apply to the affected download clients, combined per `applyTags`.
	public let tags: [Int]?
	/// How `tags` is combined with each download client's existing tags.
	public let applyTags: ApplyTags?
	/// Whether the affected download clients are enabled.
	public let enable: Bool?
	/// The order in which the affected download clients are checked relative to others of the same protocol.
	public let priority: Int?
	/// Whether completed downloads are removed from the affected download clients after import.
	public let removeCompletedDownloads: Bool?
	/// Whether failed downloads are removed from the affected download clients.
	public let removeFailedDownloads: Bool?

	/// Creates a bulk request for the given download client identifiers.
	/// - Parameters:
	///   - ids: The identifiers of the download clients to update or remove.
	///   - tags: The tags to apply to the affected download clients, combined per `applyTags`.
	///   - applyTags: How `tags` is combined with each download client's existing tags.
	///   - enable: Whether the affected download clients are enabled.
	///   - priority: The order in which the affected download clients are checked relative to others of the same
	///   protocol.
	///   - removeCompletedDownloads: Whether completed downloads are removed from the affected download clients
	///   after import.
	///   - removeFailedDownloads: Whether failed downloads are removed from the affected download clients.
	public init(
		ids: [Int]? = nil,
		tags: [Int]? = nil,
		applyTags: ApplyTags? = nil,
		enable: Bool? = nil,
		priority: Int? = nil,
		removeCompletedDownloads: Bool? = nil,
		removeFailedDownloads: Bool? = nil
	) {
		self.ids = ids
		self.tags = tags
		self.applyTags = applyTags
		self.enable = enable
		self.priority = priority
		self.removeCompletedDownloads = removeCompletedDownloads
		self.removeFailedDownloads = removeFailedDownloads
	}
}
