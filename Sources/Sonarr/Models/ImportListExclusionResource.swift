/// A series excluded from being re-added by any import list.
public struct ImportListExclusionResource: Equatable, Codable, Sendable {
	/// The unique identifier of this exclusion, if it has been saved.
	public let id: Int?
	/// The TVDB identifier of the excluded series.
	public let tvdbId: Int
	/// The title of the excluded series.
	public let title: String?

	/// Creates an import list exclusion to send to the server.
	/// - Parameters:
	///   - id: The unique identifier of this exclusion, if updating an existing one.
	///   - tvdbId: The TVDB identifier of the excluded series.
	///   - title: The title of the excluded series.
	public init(id: Int? = nil, tvdbId: Int, title: String? = nil) {
		self.id = id
		self.tvdbId = tvdbId
		self.title = title
	}
}
