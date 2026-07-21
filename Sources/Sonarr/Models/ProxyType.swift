/// The protocol used to connect to a proxy server.
public enum ProxyType: String, Equatable, Codable, Sendable {
	/// Connect via an HTTP proxy.
	case http
	/// Connect via a SOCKS4 proxy.
	case socks4
	/// Connect via a SOCKS5 proxy.
	case socks5
}
