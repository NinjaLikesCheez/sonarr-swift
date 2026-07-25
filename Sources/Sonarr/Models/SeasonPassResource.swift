/// A request body describing bulk season monitoring changes across series.
public struct SeasonPassResource: Equatable, Codable, Sendable {
	/// The series and season monitoring changes to apply.
	public let series: [SeasonPassSeriesResource]?
	/// Options controlling how the requested monitoring changes cascade to episodes.
	public let monitoringOptions: MonitoringOptions?

	/// Creates a season pass update to send to the server.
	/// - Parameters:
	///   - series: The series and season monitoring changes to apply.
	///   - monitoringOptions: Options controlling how the requested monitoring changes cascade to episodes.
	public init(series: [SeasonPassSeriesResource]? = nil, monitoringOptions: MonitoringOptions? = nil) {
		self.series = series
		self.monitoringOptions = monitoringOptions
	}
}
