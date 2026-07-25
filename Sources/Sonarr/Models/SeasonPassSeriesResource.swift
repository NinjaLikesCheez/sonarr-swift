/// A series and the season monitoring changes to apply to it as part of a season pass update.
public struct SeasonPassSeriesResource: Equatable, Codable, Sendable {
	/// The unique identifier of the series.
	public let id: Int?
	/// Whether the series itself should be monitored.
	public let monitored: Bool?
	/// The seasons to update, with their new monitoring state.
	public let seasons: [SeasonResource]?

	/// Creates a season pass series entry to send to the server.
	/// - Parameters:
	///   - id: The unique identifier of the series.
	///   - monitored: Whether the series itself should be monitored.
	///   - seasons: The seasons to update, with their new monitoring state.
	public init(id: Int? = nil, monitored: Bool? = nil, seasons: [SeasonResource]? = nil) {
		self.id = id
		self.monitored = monitored
		self.seasons = seasons
	}
}
