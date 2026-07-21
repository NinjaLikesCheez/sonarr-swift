/// A URI broken down into its component parts, as reported by the server.
public struct HttpUri: Equatable, Decodable, Sendable {
	/// The complete URI string.
	public let fullUri: String?
	/// The URI scheme, e.g. `https`.
	public let scheme: String?
	/// The host component of the URI.
	public let host: String?
	/// The port component of the URI.
	public let port: Int?
	/// The path component of the URI.
	public let path: String?
	/// The query string component of the URI.
	public let query: String?
	/// The fragment component of the URI.
	public let fragment: String?
}
