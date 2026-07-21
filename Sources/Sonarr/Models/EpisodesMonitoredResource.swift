/// The request body for updating the monitored state of multiple episodes at once.
public struct EpisodesMonitoredResource: Equatable, Encodable, Sendable {
	/// The identifiers of the episodes to update.
	public let episodeIds: [Int]?
	/// Whether the affected episodes should be monitored.
	public let monitored: Bool

	/// Creates a monitor request for the given episode identifiers.
	/// - Parameters:
	///   - episodeIds: The identifiers of the episodes to update.
	///   - monitored: Whether the affected episodes should be monitored.
	public init(episodeIds: [Int]? = nil, monitored: Bool) {
		self.episodeIds = episodeIds
		self.monitored = monitored
	}
}
