/// The UI translation strings for a language known to Sonarr.
public struct LocalizationResource: Equatable, Decodable, Sendable {
	/// The unique identifier of this localization.
	public let id: Int?
	/// The translated UI strings, keyed by translation key.
	public let strings: [String: String]?
}
