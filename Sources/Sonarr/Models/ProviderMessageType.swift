/// The severity of a `ProviderMessage` shown alongside a provider (e.g. a download client) in the UI.
public enum ProviderMessageType: String, Equatable, Codable, Sendable {
	case info
	case warning
	case error
}
