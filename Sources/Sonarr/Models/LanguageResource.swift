/// A language known to Sonarr, as returned by the language configuration endpoints.
public struct LanguageResource: Equatable, Decodable, Sendable {
	/// The unique identifier of the language.
	public let id: Int?
	/// The display name of the language.
	public let name: String?
	/// The lowercased name of the language, as used for matching.
	public let nameLower: String?
}
