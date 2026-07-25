/// The result of a health check against the server, independent of authentication.
public struct PingResource: Equatable, Decodable, Sendable {
	/// The server's reported status, e.g. `OK`.
	public let status: String?
}
