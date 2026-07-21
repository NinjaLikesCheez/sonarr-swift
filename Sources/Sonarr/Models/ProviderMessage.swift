/// An informational or warning message Sonarr attaches to a provider (e.g. a download client).
public struct ProviderMessage: Equatable, Codable, Sendable {
	/// The message text.
	public let message: String?
	/// The severity of the message.
	public let type: ProviderMessageType
}
