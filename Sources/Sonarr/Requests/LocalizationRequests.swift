public extension SonarrRequest where SonarrResponse == LocalizationResource {
	/// Gets the active UI localization.
	///
	/// Endpoint: `GET /api/v3/localization`
	///
	/// Result: the current localization strings.
	static var localization: SonarrRequest<LocalizationResource> {
		SonarrRequest(method: .get, path: "api/v3/localization")
	}

	/// Gets a localization by ID.
	///
	/// Endpoint: `GET /api/v3/localization/{id}`
	///
	/// Result: the requested localization strings.
	///
	/// - Parameter id: The unique identifier of the localization.
	static func localization(id: Int) -> SonarrRequest<LocalizationResource> {
		SonarrRequest(method: .get, path: "api/v3/localization/\(id)")
	}
}

public extension SonarrRequest where SonarrResponse == LocalizationLanguageResource {
	/// Gets the language Sonarr's UI is currently localized to.
	///
	/// Endpoint: `GET /api/v3/localization/language`
	///
	/// Result: the active UI language.
	static var localizationLanguage: SonarrRequest<LocalizationLanguageResource> {
		SonarrRequest(method: .get, path: "api/v3/localization/language")
	}
}
