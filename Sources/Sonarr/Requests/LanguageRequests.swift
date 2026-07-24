public extension SonarrRequest where SonarrResponse == [LanguageResource] {
	/// Gets the languages known to Sonarr.
	///
	/// Endpoint: `GET /api/v3/language`
	///
	/// Result: the languages known to the server.
	static var languages: SonarrRequest<[LanguageResource]> {
		SonarrRequest(method: .get, path: "api/v3/language")
	}
}

public extension SonarrRequest where SonarrResponse == LanguageResource {
	/// Gets a language known to Sonarr by ID.
	///
	/// Endpoint: `GET /api/v3/language/{id}`
	///
	/// Result: the requested language.
	///
	/// - Parameter id: The unique identifier of the language.
	static func language(id: Int) -> SonarrRequest<LanguageResource> {
		SonarrRequest(method: .get, path: "api/v3/language/\(id)")
	}
}
