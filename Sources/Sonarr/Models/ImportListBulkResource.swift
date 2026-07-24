/// The request body for bulk-updating or bulk-removing import lists.
public struct ImportListBulkResource: Equatable, Encodable, Sendable {
	/// The identifiers of the import lists to update or remove.
	public let ids: [Int]?
	/// The tags to apply to the affected import lists, combined per `applyTags`.
	public let tags: [Int]?
	/// How `tags` is combined with each import list's existing tags.
	public let applyTags: ApplyTags?
	/// Whether series from the affected import lists are added to Sonarr automatically.
	public let enableAutomaticAdd: Bool?
	/// The root folder series from the affected import lists are added under.
	public let rootFolderPath: String?
	/// The quality profile assigned to series added from the affected import lists.
	public let qualityProfileId: Int?

	/// Creates a bulk request for the given import list identifiers.
	/// - Parameters:
	///   - ids: The identifiers of the import lists to update or remove.
	///   - tags: The tags to apply to the affected import lists, combined per `applyTags`.
	///   - applyTags: How `tags` is combined with each import list's existing tags.
	///   - enableAutomaticAdd: Whether series from the affected import lists are added to Sonarr automatically.
	///   - rootFolderPath: The root folder series from the affected import lists are added under.
	///   - qualityProfileId: The quality profile assigned to series added from the affected import lists.
	public init(
		ids: [Int]? = nil,
		tags: [Int]? = nil,
		applyTags: ApplyTags? = nil,
		enableAutomaticAdd: Bool? = nil,
		rootFolderPath: String? = nil,
		qualityProfileId: Int? = nil
	) {
		self.ids = ids
		self.tags = tags
		self.applyTags = applyTags
		self.enableAutomaticAdd = enableAutomaticAdd
		self.rootFolderPath = rootFolderPath
		self.qualityProfileId = qualityProfileId
	}
}
