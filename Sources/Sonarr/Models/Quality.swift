/// A quality definition Sonarr can match releases against.
public struct Quality: Equatable, Decodable, Sendable {
	/// Sonarr's internal identifier for the quality.
	public let id: Int
	/// The display name of the quality, e.g. `WEBDL-1080p`.
	public let name: String
	/// The source Sonarr detected the release from, e.g. `web`.
	public let source: String
	/// The vertical resolution of the release, in pixels.
	public let resolution: Int
}

/// The version metadata Sonarr attaches to a matched quality, e.g. proper/repack revisions.
public struct QualityRevision: Equatable, Decodable, Sendable {
	/// The revision version; incremented for propers.
	public let version: Int
	/// The "real" revision count Sonarr assigns to REAL releases.
	public let real: Int
	/// Whether the release is a repack.
	public let isRepack: Bool
}

/// The quality Sonarr matched for a release, along with its revision metadata.
public struct QualityModel: Equatable, Decodable, Sendable {
	/// The matched quality.
	public let quality: Quality
	/// The revision metadata for the matched quality.
	public let revision: QualityRevision
}
