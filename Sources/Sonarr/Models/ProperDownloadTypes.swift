/// How Sonarr handles proper/repack releases of episodes it already has.
public enum ProperDownloadTypes: String, Equatable, Codable, Sendable {
	/// Propers and repacks are preferred and automatically upgraded to.
	case preferAndUpgrade
	/// Propers and repacks are not automatically upgraded to.
	case doNotUpgrade
	/// Propers and repacks are not preferred over the original release.
	case doNotPrefer
}
