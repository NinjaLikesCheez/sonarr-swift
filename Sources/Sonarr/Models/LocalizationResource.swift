/// The UI translation strings for a language known to Sonarr.
public struct LocalizationResource: Equatable, Decodable, Sendable {
	// The live server omits `id` entirely from both `GET /api/v3/localization` and
	// `GET /api/v3/localization/{id}` responses (the latter ignores the id path parameter and always
	// returns the current localization) — don't assume it's present.
	/// The unique identifier of this localization, if the server provides one.
	public let id: Int?
	/// The translated UI strings, keyed by translation key.
	public let strings: [String: String]?
}
