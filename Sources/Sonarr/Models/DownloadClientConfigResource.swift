/// The global download client configuration.
public struct DownloadClientConfigResource: Equatable, Codable, Sendable {
	/// The unique identifier of the download client configuration.
	public let id: Int?
	/// A comma-separated list of folder names Sonarr treats as in-progress download folders.
	public let downloadClientWorkingFolders: String?
	/// Whether Sonarr should track and import completed downloads automatically.
	public let enableCompletedDownloadHandling: Bool
	/// Whether Sonarr should automatically search for a replacement when a download fails.
	public let autoRedownloadFailed: Bool
	/// Whether Sonarr should automatically search for a replacement when a download from an interactive search fails.
	public let autoRedownloadFailedFromInteractiveSearch: Bool

	/// Creates a download client configuration.
	///
	/// - Parameters:
	///   - id: The unique identifier of the download client configuration.
	///   - downloadClientWorkingFolders: A comma-separated list of folder names Sonarr treats as in-progress download
	///   folders.
	///   - enableCompletedDownloadHandling: Whether Sonarr should track and import completed downloads automatically.
	///   - autoRedownloadFailed: Whether Sonarr should automatically search for a replacement when a download fails.
	///   - autoRedownloadFailedFromInteractiveSearch: Whether Sonarr should automatically search for a replacement
	///   when a download from an interactive search fails.
	public init(
		id: Int? = nil,
		downloadClientWorkingFolders: String? = nil,
		enableCompletedDownloadHandling: Bool,
		autoRedownloadFailed: Bool,
		autoRedownloadFailedFromInteractiveSearch: Bool
	) {
		self.id = id
		self.downloadClientWorkingFolders = downloadClientWorkingFolders
		self.enableCompletedDownloadHandling = enableCompletedDownloadHandling
		self.autoRedownloadFailed = autoRedownloadFailed
		self.autoRedownloadFailedFromInteractiveSearch = autoRedownloadFailedFromInteractiveSearch
	}
}
