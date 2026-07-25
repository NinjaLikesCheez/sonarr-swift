/// When Sonarr requires an episode title before importing a file.
public enum EpisodeTitleRequiredType: String, Equatable, Codable, Sendable {
	/// An episode title is always required.
	case always
	/// An episode title is required only for releases containing more than one episode.
	case bulkSeasonReleases
	/// An episode title is never required.
	case never
}
