/// A single health check result reported by the server.
public struct HealthResource: Equatable, Decodable, Sendable {
	// Sonarr's OpenAPI spec marks `id` as required, but the live server omits it from
	// `GET /api/v3/health` responses — health checks are computed on the fly, not persisted
	// records with an ID.
	/// The unique identifier of this health check result, if the server provides one.
	public let id: Int?
	/// The component or subsystem that produced this result.
	public let source: String?
	/// The severity of the result.
	public let type: HealthCheckResult
	/// A human-readable description of the issue, if any.
	public let message: String?
	// Sonarr's OpenAPI spec models `wikiUrl` as a structured `HttpUri` object, but the live
	// server sends it as a plain URL string.
	/// A link to the wiki article explaining this health check, if available.
	public let wikiUrl: String?
}
