/// Confirmation that Sonarr has begun restarting.
public struct SystemRestartResource: Equatable, Decodable, Sendable {
	/// Whether Sonarr is restarting.
	public let restarting: Bool
}
