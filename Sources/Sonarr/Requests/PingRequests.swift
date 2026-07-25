public extension SonarrRequest where SonarrResponse == PingResource {
	/// Checks whether the server is reachable and responding.
	///
	/// Endpoint: `GET /ping`
	///
	/// Result: the server's reported status. Unlike other endpoints, this one lives at the server root (not under
	/// `api/v3`) and doesn't require an API key.
	static var ping: SonarrRequest<PingResource> {
		SonarrRequest(method: .get, path: "ping")
	}
}
