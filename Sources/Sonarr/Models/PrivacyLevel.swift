/// How sensitive a `Field`'s value is, e.g. whether it should be masked in the UI.
public enum PrivacyLevel: String, Equatable, Codable, Sendable {
	case normal
	case password
	case apiKey
	case userName
}
