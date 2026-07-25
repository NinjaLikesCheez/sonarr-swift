/// An alternate (e.g. scene) title Sonarr matched a release against.
public struct AlternateTitleResource: Equatable, Codable, Sendable {
	/// The alternate title text.
	public let title: String?
	/// The season this alternate title applies to, if scoped to a single season.
	public let seasonNumber: Int?
	/// The scene-numbered season this alternate title maps to, if different from `seasonNumber`.
	public let sceneSeasonNumber: Int?
	/// Where this alternate title originated, e.g. `tvdb`.
	public let sceneOrigin: String?
	/// A note explaining why this alternate title exists.
	public let comment: String?

	/// Creates an alternate title value.
	/// - Parameters:
	///   - title: The alternate title text.
	///   - seasonNumber: The season this alternate title applies to, if scoped to a single season.
	///   - sceneSeasonNumber: The scene-numbered season this alternate title maps to, if different from `seasonNumber`.
	///   - sceneOrigin: Where this alternate title originated, e.g. `tvdb`.
	///   - comment: A note explaining why this alternate title exists.
	public init(
		title: String? = nil,
		seasonNumber: Int? = nil,
		sceneSeasonNumber: Int? = nil,
		sceneOrigin: String? = nil,
		comment: String? = nil
	) {
		self.title = title
		self.seasonNumber = seasonNumber
		self.sceneSeasonNumber = sceneSeasonNumber
		self.sceneOrigin = sceneOrigin
		self.comment = comment
	}
}
