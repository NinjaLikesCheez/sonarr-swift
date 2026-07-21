/// A language Sonarr can match releases against.
public struct Language: Equatable, Codable, Sendable {
	/// Sonarr's internal identifier for the language.
	public let id: Int
	/// The display name of the language, e.g. `English`.
	public let name: String

	/// Creates a language value.
	/// - Parameters:
	///   - id: Sonarr's internal identifier for the language.
	///   - name: The display name of the language.
	public init(id: Int, name: String) {
		self.id = id
		self.name = name
	}
}
