/// How Sonarr applies updates to itself.
public enum UpdateMechanism: String, Equatable, Codable, Sendable {
	/// Sonarr updates itself using its built-in updater.
	case builtIn
	/// Sonarr runs a user-provided script to perform the update.
	case script
	/// Updates are handled by an external mechanism (e.g. a package manager).
	case external
	/// Sonarr is updated via an APT package.
	case apt
	/// Sonarr is updated via its Docker image.
	case docker
}
