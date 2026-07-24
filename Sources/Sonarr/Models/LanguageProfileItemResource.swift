/// A single language entry within a language profile's ranked language list.
public struct LanguageProfileItemResource: Equatable, Codable, Sendable {
	/// The unique identifier of this entry.
	public let id: Int?
	/// The language this entry represents.
	public let language: Language?
	/// Whether this language is allowed by the profile.
	public let allowed: Bool?

	/// Creates a language profile item.
	///
	/// - Parameters:
	///   - id: The unique identifier of this entry.
	///   - language: The language this entry represents.
	///   - allowed: Whether this language is allowed by the profile.
	public init(
		id: Int? = nil,
		language: Language? = nil,
		allowed: Bool? = nil
	) {
		self.id = id
		self.language = language
		self.allowed = allowed
	}
}
