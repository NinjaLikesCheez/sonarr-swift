/// The request body for bulk-updating or bulk-removing indexers.
public struct IndexerBulkResource: Equatable, Encodable, Sendable {
	/// The identifiers of the indexers to update or remove.
	public let ids: [Int]?
	/// The tags to apply to the affected indexers, combined per `applyTags`.
	public let tags: [Int]?
	/// How `tags` is combined with each indexer's existing tags.
	public let applyTags: ApplyTags?
	/// Whether the affected indexers grab releases from their RSS feed automatically.
	public let enableRss: Bool?
	/// Whether the affected indexers are searched during automatic searches.
	public let enableAutomaticSearch: Bool?
	/// Whether the affected indexers are searched during interactive (manual) searches.
	public let enableInteractiveSearch: Bool?
	/// The priority applied to the affected indexers; lower values are preferred.
	public let priority: Int?

	/// Creates a bulk request for the given indexer identifiers.
	/// - Parameters:
	///   - ids: The identifiers of the indexers to update or remove.
	///   - tags: The tags to apply to the affected indexers, combined per `applyTags`.
	///   - applyTags: How `tags` is combined with each indexer's existing tags.
	///   - enableRss: Whether the affected indexers grab releases from their RSS feed automatically.
	///   - enableAutomaticSearch: Whether the affected indexers are searched during automatic searches.
	///   - enableInteractiveSearch: Whether the affected indexers are searched during interactive (manual) searches.
	///   - priority: The priority applied to the affected indexers; lower values are preferred.
	public init(
		ids: [Int]? = nil,
		tags: [Int]? = nil,
		applyTags: ApplyTags? = nil,
		enableRss: Bool? = nil,
		enableAutomaticSearch: Bool? = nil,
		enableInteractiveSearch: Bool? = nil,
		priority: Int? = nil
	) {
		self.ids = ids
		self.tags = tags
		self.applyTags = applyTags
		self.enableRss = enableRss
		self.enableAutomaticSearch = enableAutomaticSearch
		self.enableInteractiveSearch = enableInteractiveSearch
		self.priority = priority
	}
}
