/// Options controlling how a newly added series' episodes are monitored and searched for.
public struct AddSeriesOptions: Equatable, Codable, Sendable {
	/// Whether to unmonitor episodes that already have a file.
	public let ignoreEpisodesWithFiles: Bool?
	/// Whether to unmonitor episodes that don't have a file.
	public let ignoreEpisodesWithoutFiles: Bool?
	/// The monitoring strategy to apply to the series' episodes.
	public let monitor: MonitorTypes?
	/// Whether to search for missing episodes immediately after adding the series.
	public let searchForMissingEpisodes: Bool?
	/// Whether to search for cutoff-unmet episodes immediately after adding the series.
	public let searchForCutoffUnmetEpisodes: Bool?

	/// Creates add-series options to send to the server.
	/// - Parameters:
	///   - ignoreEpisodesWithFiles: Whether to unmonitor episodes that already have a file.
	///   - ignoreEpisodesWithoutFiles: Whether to unmonitor episodes that don't have a file.
	///   - monitor: The monitoring strategy to apply to the series' episodes.
	///   - searchForMissingEpisodes: Whether to search for missing episodes immediately after adding the series.
	///   - searchForCutoffUnmetEpisodes: Whether to search for cutoff-unmet episodes immediately after adding the
	///   series.
	public init(
		ignoreEpisodesWithFiles: Bool? = nil,
		ignoreEpisodesWithoutFiles: Bool? = nil,
		monitor: MonitorTypes? = nil,
		searchForMissingEpisodes: Bool? = nil,
		searchForCutoffUnmetEpisodes: Bool? = nil
	) {
		self.ignoreEpisodesWithFiles = ignoreEpisodesWithFiles
		self.ignoreEpisodesWithoutFiles = ignoreEpisodesWithoutFiles
		self.monitor = monitor
		self.searchForMissingEpisodes = searchForMissingEpisodes
		self.searchForCutoffUnmetEpisodes = searchForCutoffUnmetEpisodes
	}
}
