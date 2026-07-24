/// A language profile, ranking languages by preference for a series.
///
/// Language profiles were removed in Sonarr v4; most operations on this type are deprecated, but the type
/// itself remains current since `GET /api/v3/languageprofile/{id}` is not.
public struct LanguageProfileResource: Equatable, Codable, Sendable {
	/// The unique identifier of the language profile.
	public let id: Int?
	/// The display name of the language profile.
	public let name: String?
	/// Whether Sonarr is allowed to upgrade an episode's language once the cutoff is met.
	public let upgradeAllowed: Bool?
	/// The language at which Sonarr stops upgrading an episode's language.
	public let cutoff: Language?
	/// The ranked list of languages allowed by this profile.
	public let languages: [LanguageProfileItemResource]?

	/// Creates a language profile.
	///
	/// - Parameters:
	///   - id: The unique identifier of the language profile.
	///   - name: The display name of the language profile.
	///   - upgradeAllowed: Whether Sonarr is allowed to upgrade an episode's language once the cutoff is met.
	///   - cutoff: The language at which Sonarr stops upgrading an episode's language.
	///   - languages: The ranked list of languages allowed by this profile.
	public init(
		id: Int? = nil,
		name: String? = nil,
		upgradeAllowed: Bool? = nil,
		cutoff: Language? = nil,
		languages: [LanguageProfileItemResource]? = nil
	) {
		self.id = id
		self.name = name
		self.upgradeAllowed = upgradeAllowed
		self.cutoff = cutoff
		self.languages = languages
	}
}
