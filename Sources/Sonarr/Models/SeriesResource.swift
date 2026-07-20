import Foundation

// Minimal projection of Sonarr's SeriesResource - only the fields needed by endpoints outside the
// Series tag (e.g. Calendar's `includeSeries`). The full resource will be fleshed out when the
// Series tag itself is implemented.

/// A series known to Sonarr.
public struct SeriesResource: Equatable, Decodable, Sendable {
	/// Sonarr's internal identifier for the series.
	public let id: Int
	/// The title of the series.
	public let title: String
	/// The title used for sorting.
	public let sortTitle: String?
	/// A synopsis of the series.
	public let overview: String?
	/// The broadcast network the series airs on.
	public let network: String?
	/// The year the series first aired.
	public let year: Int
	/// The folder the series' files are stored in.
	public let path: String?
	/// The identifier of the quality profile applied to the series.
	public let qualityProfileId: Int
	/// Whether the series is monitored for new episodes.
	public let monitored: Bool
	/// The identifier of the series on TheTVDB.
	public let tvdbId: Int
	/// The artwork associated with the series.
	public let images: [MediaCover]?
	/// The identifiers of the tags applied to the series.
	public let tags: [Int]?
}
