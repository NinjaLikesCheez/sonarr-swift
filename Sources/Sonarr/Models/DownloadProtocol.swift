/// The download protocol used to fetch a release.
public enum DownloadProtocol: String, Equatable, Codable, Sendable {
	/// The protocol could not be determined.
	case unknown
	/// The release was fetched via Usenet.
	case usenet
	/// The release was fetched via a torrent.
	case torrent
}
