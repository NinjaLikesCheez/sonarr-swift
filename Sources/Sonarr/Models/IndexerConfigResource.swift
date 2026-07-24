/// The global indexer configuration.
public struct IndexerConfigResource: Equatable, Codable, Sendable {
	/// The unique identifier of the indexer configuration.
	public let id: Int?
	/// The minimum age (in minutes) of a release before it is grabbed, used to allow Usenet indexers to propagate.
	public let minimumAge: Int?
	/// The number of days to keep a release in the download history.
	public let retention: Int?
	/// The maximum size (in megabytes) of a release before it is rejected.
	public let maximumSize: Int?
	/// The interval (in minutes) between RSS sync operations.
	public let rssSyncInterval: Int?

	/// Creates an indexer configuration.
	///
	/// - Parameters:
	///   - id: The unique identifier of the indexer configuration.
	///   - minimumAge: The minimum age (in minutes) of a release before it is grabbed, used to allow Usenet indexers to propagate.
	///   - retention: The number of days to keep a release in the download history.
	///   - maximumSize: The maximum size (in megabytes) of a release before it is rejected.
	///   - rssSyncInterval: The interval (in minutes) between RSS sync operations.
	public init(
		id: Int? = nil,
		minimumAge: Int? = nil,
		retention: Int? = nil,
		maximumSize: Int? = nil,
		rssSyncInterval: Int? = nil
	) {
		self.id = id
		self.minimumAge = minimumAge
		self.retention = retention
		self.maximumSize = maximumSize
		self.rssSyncInterval = rssSyncInterval
	}
}
