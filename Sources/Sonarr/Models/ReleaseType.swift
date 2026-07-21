/// The kind of release an episode file was matched from.
public enum ReleaseType: String, Equatable, Codable, Sendable {
	/// The release type could not be determined.
	case unknown
	/// The release contains a single episode.
	case singleEpisode
	/// The release contains multiple episodes.
	case multiEpisode
	/// The release contains a full season.
	case seasonPack
}
