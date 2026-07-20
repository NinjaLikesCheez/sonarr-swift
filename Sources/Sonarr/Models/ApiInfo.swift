/// The API versions supported by a Sonarr server.
public struct ApiInfo: Equatable, Decodable, Sendable {
	/// The current, recommended API version, e.g. `v3`.
	public let current: String
	/// API versions that are still available but deprecated.
	public let deprecated: [String]
}
