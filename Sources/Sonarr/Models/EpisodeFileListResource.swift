/// The request body for updating or deleting multiple episode files at once.
public struct EpisodeFileListResource: Equatable, Encodable, Sendable {
	/// The identifiers of the episode files to update or delete.
	public let episodeFileIds: [Int]?
	/// The languages to apply to the affected episode files.
	public let languages: [Language]?
	/// The quality to apply to the affected episode files.
	public let quality: QualityModel?
	/// The scene name to apply to the affected episode files.
	public let sceneName: String?
	/// The release group to apply to the affected episode files.
	public let releaseGroup: String?

	/// Creates an episode file editor/bulk request.
	/// - Parameters:
	///   - episodeFileIds: The identifiers of the episode files to update or delete.
	///   - languages: The languages to apply to the affected episode files.
	///   - quality: The quality to apply to the affected episode files.
	///   - sceneName: The scene name to apply to the affected episode files.
	///   - releaseGroup: The release group to apply to the affected episode files.
	public init(
		episodeFileIds: [Int]? = nil,
		languages: [Language]? = nil,
		quality: QualityModel? = nil,
		sceneName: String? = nil,
		releaseGroup: String? = nil
	) {
		self.episodeFileIds = episodeFileIds
		self.languages = languages
		self.quality = quality
		self.sceneName = sceneName
		self.releaseGroup = releaseGroup
	}
}
