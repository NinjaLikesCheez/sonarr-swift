/// A mapping between a remote download client's path and its equivalent local path.
public struct RemotePathMappingResource: Equatable, Codable, Sendable {
	/// The unique identifier of this mapping, if it has been saved.
	public let id: Int?
	/// The host of the download client this mapping applies to.
	public let host: String?
	/// The path as reported by the remote download client.
	public let remotePath: String?
	/// The equivalent path on the system running Sonarr.
	public let localPath: String?

	/// Creates a remote path mapping to send to the server.
	/// - Parameters:
	///   - id: The unique identifier of this mapping, if updating an existing one.
	///   - host: The host of the download client this mapping applies to.
	///   - remotePath: The path as reported by the remote download client.
	///   - localPath: The equivalent path on the system running Sonarr.
	public init(
		id: Int? = nil,
		host: String? = nil,
		remotePath: String? = nil,
		localPath: String? = nil
	) {
		self.id = id
		self.host = host
		self.remotePath = remotePath
		self.localPath = localPath
	}
}
