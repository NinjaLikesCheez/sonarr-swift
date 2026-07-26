/// The mode Sonarr's process is running under.
public enum RuntimeMode: String, Equatable, Codable, Sendable {
	/// Sonarr is running as a console application.
	case console
	/// Sonarr is running as a system service.
	case service
	/// Sonarr is running from the Windows system tray.
	case tray
}
