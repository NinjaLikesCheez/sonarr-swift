/// The series title Sonarr parsed out of a release name.
public struct SeriesTitleInfo: Equatable, Decodable, Sendable {
	/// The parsed series title, including the year if present.
	public let title: String?
	/// The parsed series title, with any trailing year removed.
	public let titleWithoutYear: String?
	/// The year parsed from the title, if present.
	public let year: Int?
	/// All title variants Sonarr considered a match, e.g. alternate spellings.
	public let allTitles: [String]?
}
