import APIClient
import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public extension SonarrRequest where SonarrResponse == NamingConfigResource {
	/// Gets the global naming configuration.
	///
	/// Endpoint: `GET /api/v3/config/naming`
	///
	/// Result: the current naming configuration.
	static var namingConfig: SonarrRequest<NamingConfigResource> {
		SonarrRequest(method: .get, path: "api/v3/config/naming")
	}

	/// Gets the global naming configuration by ID.
	///
	/// Endpoint: `GET /api/v3/config/naming/{id}`
	///
	/// Result: the requested naming configuration.
	///
	/// - Parameter id: The unique identifier of the naming configuration.
	static func namingConfig(id: Int) -> SonarrRequest<NamingConfigResource> {
		SonarrRequest(method: .get, path: "api/v3/config/naming/\(id)")
	}

	/// Updates the global naming configuration.
	///
	/// Endpoint: `PUT /api/v3/config/naming/{id}`
	///
	/// Result: the updated naming configuration.
	///
	/// - Parameters:
	///   - id: The unique identifier of the naming configuration.
	///   - namingConfig: The new naming configuration.
	static func updateNamingConfig(
		id: Int,
		_ namingConfig: NamingConfigResource
	) -> SonarrRequest<NamingConfigResource> {
		SonarrRequest(method: .put, path: "api/v3/config/naming/\(id)", body: { JSONBody(namingConfig) })
	}
}

public extension SonarrRequest where SonarrResponse == NamingConfigExamplesResource {
	/// Gets example file/folder names produced by a set of naming configuration formats.
	///
	/// Endpoint: `GET /api/v3/config/naming/examples`
	///
	/// Result: example names for each configured format. Parameters left unset fall back to the server's currently
	/// saved configuration.
	///
	/// - Parameters:
	///   - id: The unique identifier of the naming configuration to base the examples on.
	///   - renameEpisodes: Whether episode files would be renamed to match the configured formats.
	///   - replaceIllegalCharacters: Whether characters that are illegal in file names would be replaced.
	///   - colonReplacementFormat: The replacement used for colons in file/folder names, as a server-defined ordinal.
	///   - customColonReplacementFormat: The custom replacement string used when `colonReplacementFormat` selects a
	///   custom replacement.
	///   - multiEpisodeStyle: How files containing multiple episodes would be named, as a server-defined ordinal.
	///   - standardEpisodeFormat: The naming format applied to standard (non-daily, non-anime) episode files.
	///   - dailyEpisodeFormat: The naming format applied to daily episode files.
	///   - animeEpisodeFormat: The naming format applied to anime episode files.
	///   - seriesFolderFormat: The naming format applied to series folders.
	///   - seasonFolderFormat: The naming format applied to season folders.
	///   - specialsFolderFormat: The naming format applied to the specials folder.
	static func namingConfigExamples(
		id: Int? = nil,
		renameEpisodes: Bool? = nil,
		replaceIllegalCharacters: Bool? = nil,
		colonReplacementFormat: Int? = nil,
		customColonReplacementFormat: String? = nil,
		multiEpisodeStyle: Int? = nil,
		standardEpisodeFormat: String? = nil,
		dailyEpisodeFormat: String? = nil,
		animeEpisodeFormat: String? = nil,
		seriesFolderFormat: String? = nil,
		seasonFolderFormat: String? = nil,
		specialsFolderFormat: String? = nil
	) -> SonarrRequest<NamingConfigExamplesResource> {
		var queryItems: [URLQueryItem] = []

		if let id {
			queryItems.append(URLQueryItem(name: "id", value: String(id)))
		}

		if let renameEpisodes {
			queryItems.append(URLQueryItem(name: "renameEpisodes", value: String(renameEpisodes)))
		}

		if let replaceIllegalCharacters {
			queryItems.append(
				URLQueryItem(name: "replaceIllegalCharacters", value: String(replaceIllegalCharacters))
			)
		}

		if let colonReplacementFormat {
			queryItems.append(URLQueryItem(name: "colonReplacementFormat", value: String(colonReplacementFormat)))
		}

		if let customColonReplacementFormat {
			queryItems.append(
				URLQueryItem(name: "customColonReplacementFormat", value: customColonReplacementFormat)
			)
		}

		if let multiEpisodeStyle {
			queryItems.append(URLQueryItem(name: "multiEpisodeStyle", value: String(multiEpisodeStyle)))
		}

		if let standardEpisodeFormat {
			queryItems.append(URLQueryItem(name: "standardEpisodeFormat", value: standardEpisodeFormat))
		}

		if let dailyEpisodeFormat {
			queryItems.append(URLQueryItem(name: "dailyEpisodeFormat", value: dailyEpisodeFormat))
		}

		if let animeEpisodeFormat {
			queryItems.append(URLQueryItem(name: "animeEpisodeFormat", value: animeEpisodeFormat))
		}

		if let seriesFolderFormat {
			queryItems.append(URLQueryItem(name: "seriesFolderFormat", value: seriesFolderFormat))
		}

		if let seasonFolderFormat {
			queryItems.append(URLQueryItem(name: "seasonFolderFormat", value: seasonFolderFormat))
		}

		if let specialsFolderFormat {
			queryItems.append(URLQueryItem(name: "specialsFolderFormat", value: specialsFolderFormat))
		}

		return SonarrRequest(method: .get, path: "api/v3/config/naming/examples", queryItems: queryItems)
	}
}
