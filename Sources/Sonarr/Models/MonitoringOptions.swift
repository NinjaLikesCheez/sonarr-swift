/// Options controlling how monitoring is applied when adding a series or updating a season pass.
public struct MonitoringOptions: Equatable, Codable, Sendable {
	/// Whether to unmonitor episodes that already have a file.
	public let ignoreEpisodesWithFiles: Bool?
	/// Whether to unmonitor episodes that don't have a file.
	public let ignoreEpisodesWithoutFiles: Bool?
	/// The monitoring strategy to apply.
	public let monitor: MonitorTypes?

	/// Creates monitoring options to send to the server.
	/// - Parameters:
	///   - ignoreEpisodesWithFiles: Whether to unmonitor episodes that already have a file.
	///   - ignoreEpisodesWithoutFiles: Whether to unmonitor episodes that don't have a file.
	///   - monitor: The monitoring strategy to apply.
	public init(
		ignoreEpisodesWithFiles: Bool? = nil,
		ignoreEpisodesWithoutFiles: Bool? = nil,
		monitor: MonitorTypes? = nil
	) {
		self.ignoreEpisodesWithFiles = ignoreEpisodesWithFiles
		self.ignoreEpisodesWithoutFiles = ignoreEpisodesWithoutFiles
		self.monitor = monitor
	}
}
