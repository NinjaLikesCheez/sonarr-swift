/// A quality definition Sonarr can match releases against.
public struct Quality: Equatable, Codable, Sendable {
	/// Sonarr's internal identifier for the quality.
	public let id: Int
	/// The display name of the quality, e.g. `WEBDL-1080p`.
	public let name: String
	/// The source Sonarr detected the release from, e.g. `web`.
	public let source: String
	/// The vertical resolution of the release, in pixels.
	public let resolution: Int

	/// Creates a quality value.
	/// - Parameters:
	///   - id: Sonarr's internal identifier for the quality.
	///   - name: The display name of the quality.
	///   - source: The source Sonarr detected the release from.
	///   - resolution: The vertical resolution of the release, in pixels.
	public init(id: Int, name: String, source: String, resolution: Int) {
		self.id = id
		self.name = name
		self.source = source
		self.resolution = resolution
	}
}

/// The version metadata Sonarr attaches to a matched quality, e.g. proper/repack revisions.
public struct QualityRevision: Equatable, Codable, Sendable {
	/// The revision version; incremented for propers.
	public let version: Int
	/// The "real" revision count Sonarr assigns to REAL releases.
	public let real: Int
	/// Whether the release is a repack.
	public let isRepack: Bool

	/// Creates a quality revision value.
	/// - Parameters:
	///   - version: The revision version; incremented for propers.
	///   - real: The "real" revision count Sonarr assigns to REAL releases.
	///   - isRepack: Whether the release is a repack.
	public init(version: Int, real: Int, isRepack: Bool) {
		self.version = version
		self.real = real
		self.isRepack = isRepack
	}
}

/// The quality Sonarr matched for a release, along with its revision metadata.
public struct QualityModel: Equatable, Codable, Sendable {
	/// The matched quality.
	public let quality: Quality
	/// The revision metadata for the matched quality.
	public let revision: QualityRevision

	/// Creates a quality model value.
	/// - Parameters:
	///   - quality: The matched quality.
	///   - revision: The revision metadata for the matched quality.
	public init(quality: Quality, revision: QualityRevision) {
		self.quality = quality
		self.revision = revision
	}
}
