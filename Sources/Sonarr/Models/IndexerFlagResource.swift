/// A flag that indexers can attach to releases (e.g. `freeleech`, `halfleech`).
public struct IndexerFlagResource: Equatable, Decodable, Sendable {
	/// The unique identifier of the indexer flag.
	public let id: Int?
	/// The display name of the flag.
	public let name: String?
	/// The lowercased name of the flag, as used for matching.
	public let nameLower: String?
}
