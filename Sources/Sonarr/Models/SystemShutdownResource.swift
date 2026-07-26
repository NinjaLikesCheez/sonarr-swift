/// Confirmation that Sonarr has begun shutting down.
public struct SystemShutdownResource: Equatable, Decodable, Sendable {
	/// Whether Sonarr is shutting down.
	public let shuttingDown: Bool
}
