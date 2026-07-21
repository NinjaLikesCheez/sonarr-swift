public extension SonarrRequest where SonarrResponse == [HealthResource] {
	/// Gets the current health check results for the server.
	///
	/// Endpoint: `GET /api/v3/health`
	///
	/// Result: the health check results reported by the server.
	static var health: SonarrRequest<[HealthResource]> {
		SonarrRequest(method: .get, path: "api/v3/health")
	}
}
