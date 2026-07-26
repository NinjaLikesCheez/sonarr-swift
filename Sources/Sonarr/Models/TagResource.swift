/// A tag Sonarr can attach to series, delay profiles, notifications, and other resources.
public struct TagResource: Equatable, Codable, Sendable {
	/// The unique identifier of this tag, if it has been saved.
	public let id: Int?
	/// The user-facing label of this tag.
	public let label: String?

	/// Creates a tag to send to the server.
	/// - Parameters:
	///   - id: The unique identifier of this tag, if updating an existing one.
	///   - label: The user-facing label of this tag.
	public init(id: Int? = nil, label: String? = nil) {
		self.id = id
		self.label = label
	}
}
