/// The score a quality profile assigns to a custom format.
public struct ProfileFormatItemResource: Equatable, Codable, Sendable {
	/// The unique identifier of this entry.
	public let id: Int?
	/// The unique identifier of the custom format this entry scores.
	public let format: Int?
	/// The name of the custom format this entry scores.
	public let name: String?
	/// The score this profile assigns to releases matching the custom format.
	public let score: Int?

	/// Creates a profile format score entry.
	/// - Parameters:
	///   - id: The unique identifier of this entry.
	///   - format: The unique identifier of the custom format this entry scores.
	///   - name: The name of the custom format this entry scores.
	///   - score: The score this profile assigns to releases matching the custom format.
	public init(id: Int? = nil, format: Int? = nil, name: String? = nil, score: Int? = nil) {
		self.id = id
		self.format = format
		self.name = name
		self.score = score
	}
}
