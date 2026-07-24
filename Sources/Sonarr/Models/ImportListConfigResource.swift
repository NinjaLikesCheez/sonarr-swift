/// The global import list configuration.
public struct ImportListConfigResource: Equatable, Codable, Sendable {
	/// The unique identifier of the import list configuration.
	public let id: Int?
	/// The synchronization level applied when a series is removed from an import list.
	public let listSyncLevel: ListSyncLevelType?
	/// The tag applied to series kept via `keepAndTag` synchronization.
	public let listSyncTag: Int?

	/// Creates an import list configuration.
	///
	/// - Parameters:
	///   - id: The unique identifier of the import list configuration.
	///   - listSyncLevel: The synchronization level applied when a series is removed from an import list.
	///   - listSyncTag: The tag applied to series kept via `keepAndTag` synchronization.
	public init(
		id: Int? = nil,
		listSyncLevel: ListSyncLevelType? = nil,
		listSyncTag: Int? = nil
	) {
		self.id = id
		self.listSyncLevel = listSyncLevel
		self.listSyncTag = listSyncTag
	}
}
