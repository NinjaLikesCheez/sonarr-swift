/// The language Sonarr's UI is currently localized to.
public struct LocalizationLanguageResource: Equatable, Decodable, Sendable {
	/// The language identifier, e.g. `en`.
	public let identifier: String?
}
