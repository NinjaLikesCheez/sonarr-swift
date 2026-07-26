import Foundation

/// A Sonarr release, as reported by the update system.
public struct UpdateResource: Equatable, Decodable, Sendable {
	/// Sonarr's internal identifier for this update entry.
	public let id: Int?
	/// The version of this release.
	public let version: String?
	/// The update branch this release belongs to.
	public let branch: String?
	/// When this release was published.
	public let releaseDate: Date?
	/// The name of the release's installer file.
	public let fileName: String?
	/// The URL to download the release from.
	public let url: String?
	/// Whether this release is currently installed.
	public let installed: Bool?
	/// When this release was installed, if applicable.
	public let installedOn: Date?
	/// Whether Sonarr is able to install this release automatically.
	public let installable: Bool?
	/// Whether this is the latest available release on its branch.
	public let latest: Bool?
	/// The notable changes included in this release.
	public let changes: UpdateChanges?
	/// The checksum of the release's installer file.
	public let hash: String?
}
