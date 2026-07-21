/// The severity of a health check result.
public enum HealthCheckResult: String, Equatable, Codable, Sendable {
	/// The check passed with no issues.
	case ok
	/// The check found something worth surfacing, but not a problem.
	case notice
	/// The check found a non-critical issue.
	case warning
	/// The check found a critical issue.
	case error
}
