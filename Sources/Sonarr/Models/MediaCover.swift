/// The kind of artwork a `MediaCover` represents.
public enum MediaCoverType: String, Equatable, Decodable, Sendable {
	case unknown
	case poster
	case banner
	case fanart
	case screenshot
	case headshot
	case clearlogo
}

/// A piece of artwork Sonarr has associated with a series or episode.
public struct MediaCover: Equatable, Decodable, Sendable {
	/// The kind of artwork this image represents.
	public let coverType: MediaCoverType
	/// The URL Sonarr serves this image from.
	public let url: String?
	/// The original remote URL Sonarr fetched this image from.
	public let remoteUrl: String?
}
