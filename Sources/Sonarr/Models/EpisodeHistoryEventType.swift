/// The kind of event recorded against an episode in Sonarr's history.
public enum EpisodeHistoryEventType: String, Equatable, Codable, Sendable, CaseIterable {
	/// The event type could not be determined.
	case unknown
	/// A release was grabbed for download.
	case grabbed
	/// A file was imported from the series folder.
	case seriesFolderImported
	/// A file was imported from the download folder.
	case downloadFolderImported
	/// A download failed.
	case downloadFailed
	/// An episode file was deleted.
	case episodeFileDeleted
	/// An episode file was renamed.
	case episodeFileRenamed
	/// A download was ignored.
	case downloadIgnored
}
