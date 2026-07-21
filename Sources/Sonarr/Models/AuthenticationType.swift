/// The authentication method used to secure Sonarr's web UI and API.
public enum AuthenticationType: String, Equatable, Codable, Sendable {
	/// No authentication is required.
	case none
	/// HTTP basic authentication.
	case basic
	/// Form-based authentication via a login page.
	case forms
	/// Authentication is handled by an external application (e.g. a reverse proxy).
	case external
}
