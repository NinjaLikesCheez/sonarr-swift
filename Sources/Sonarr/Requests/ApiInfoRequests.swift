public extension SonarrRequest where SonarrResponse == ApiInfo {
	/// Gets the API versions supported by the server.
	///
	/// Endpoint: `GET /api`
	///
	/// Result: the current and deprecated API versions.
	static var apiInfo: SonarrRequest<ApiInfo> {
		SonarrRequest(method: .get, path: "api")
	}
}
