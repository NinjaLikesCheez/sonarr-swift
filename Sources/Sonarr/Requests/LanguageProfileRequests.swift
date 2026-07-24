import APIClient
import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public extension SonarrRequest where SonarrResponse == [LanguageProfileResource] {
	/// Gets all configured language profiles.
	///
	/// Endpoint: `GET /api/v3/languageprofile`
	///
	/// Result: the saved language profiles.
	@available(*, deprecated, message: "Language profiles were removed in Sonarr v4")
	static var languageProfiles: SonarrRequest<[LanguageProfileResource]> {
		SonarrRequest(method: .get, path: "api/v3/languageprofile")
	}
}

public extension SonarrRequest where SonarrResponse == LanguageProfileResource {
	/// Creates a new language profile.
	///
	/// Endpoint: `POST /api/v3/languageprofile`
	///
	/// Result: the created language profile.
	///
	/// - Parameter languageProfile: The language profile to create.
	@available(*, deprecated, message: "Language profiles were removed in Sonarr v4")
	static func addLanguageProfile(
		_ languageProfile: LanguageProfileResource
	) -> SonarrRequest<LanguageProfileResource> {
		SonarrRequest(method: .post, path: "api/v3/languageprofile", body: { JSONBody(languageProfile) })
	}

	/// Updates an existing language profile.
	///
	/// Endpoint: `PUT /api/v3/languageprofile/{id}`
	///
	/// Result: the updated language profile.
	///
	/// - Parameters:
	///   - id: The unique identifier of the language profile to update.
	///   - languageProfile: The new language profile.
	@available(*, deprecated, message: "Language profiles were removed in Sonarr v4")
	static func updateLanguageProfile(
		id: Int,
		_ languageProfile: LanguageProfileResource
	) -> SonarrRequest<LanguageProfileResource> {
		SonarrRequest(method: .put, path: "api/v3/languageprofile/\(id)", body: { JSONBody(languageProfile) })
	}

	/// Gets a single language profile.
	///
	/// Endpoint: `GET /api/v3/languageprofile/{id}`
	///
	/// Result: the requested language profile.
	///
	/// - Parameter id: The unique identifier of the language profile.
	static func languageProfile(id: Int) -> SonarrRequest<LanguageProfileResource> {
		SonarrRequest(method: .get, path: "api/v3/languageprofile/\(id)")
	}

	/// Gets the default schema used to create a new language profile.
	///
	/// Endpoint: `GET /api/v3/languageprofile/schema`
	///
	/// Result: a language profile populated with default values.
	@available(*, deprecated, message: "Language profiles were removed in Sonarr v4")
	static var languageProfileSchema: SonarrRequest<LanguageProfileResource> {
		SonarrRequest(method: .get, path: "api/v3/languageprofile/schema")
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Deletes a language profile.
	///
	/// Endpoint: `DELETE /api/v3/languageprofile/{id}`
	///
	/// - Parameter id: The unique identifier of the language profile to delete.
	@available(*, deprecated, message: "Language profiles were removed in Sonarr v4")
	static func deleteLanguageProfile(id: Int) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .delete, path: "api/v3/languageprofile/\(id)")
	}
}
