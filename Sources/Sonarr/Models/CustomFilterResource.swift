/// A saved custom filter for a Sonarr list view (e.g. Series, History).
public struct CustomFilterResource: Equatable, Codable, Sendable {
	/// The unique identifier of this custom filter, if it has been saved.
	public let id: Int?
	/// The view this filter applies to (e.g. `"series"`, `"history"`).
	public let type: String?
	/// The user-facing name of this filter.
	public let label: String?
	/// The filter conditions, keyed by field name. Shape is defined by the `type` this filter applies to.
	public let filters: [[String: AnyCodableValue]]?

	/// Creates a custom filter to send to the server.
	/// - Parameters:
	///   - id: The unique identifier of this custom filter, if updating an existing one.
	///   - type: The view this filter applies to (e.g. `"series"`, `"history"`).
	///   - label: The user-facing name of this filter.
	///   - filters: The filter conditions, keyed by field name.
	public init(
		id: Int? = nil,
		type: String?,
		label: String?,
		filters: [[String: AnyCodableValue]]?
	) {
		self.id = id
		self.type = type
		self.label = label
		self.filters = filters
	}
}
