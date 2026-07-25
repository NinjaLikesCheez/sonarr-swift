/// When Sonarr rescans a series' folder after refreshing it.
public enum RescanAfterRefreshType: String, Equatable, Codable, Sendable {
	/// The folder is always rescanned after a refresh.
	case always
	/// The folder is only rescanned after a manually triggered refresh.
	case afterManual
	/// The folder is never automatically rescanned.
	case never
}
