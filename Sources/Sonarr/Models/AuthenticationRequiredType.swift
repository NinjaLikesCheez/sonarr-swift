/// Controls when Sonarr requires authentication.
public enum AuthenticationRequiredType: String, Equatable, Codable, Sendable {
	/// Authentication is always required.
	case enabled
	/// Authentication is not required for requests from local addresses.
	case disabledForLocalAddresses
}
