/// Controls how strictly Sonarr validates SSL certificates.
public enum CertificateValidationType: String, Equatable, Codable, Sendable {
	/// Certificates are always validated.
	case enabled
	/// Certificate validation is skipped for local addresses.
	case disabledForLocalAddresses
	/// Certificate validation is disabled entirely.
	case disabled
}
