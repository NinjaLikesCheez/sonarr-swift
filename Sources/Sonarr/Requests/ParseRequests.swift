import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public extension SonarrRequest where SonarrResponse == ParseResource {
	/// Parses a release title or file path for episode/series information.
	///
	/// Endpoint: `GET /api/v3/parse`
	///
	/// Result: the parsed episode/series information, along with any series/episode matches Sonarr inferred.
	///
	/// - Parameters:
	///   - title: The release title to parse.
	///   - path: The file path to parse.
	static func parse(title: String? = nil, path: String? = nil) -> SonarrRequest<ParseResource> {
		var queryItems: [URLQueryItem] = []

		if let title {
			queryItems.append(URLQueryItem(name: "title", value: title))
		}

		if let path {
			queryItems.append(URLQueryItem(name: "path", value: path))
		}

		return SonarrRequest(method: .get, path: "api/v3/parse", queryItems: queryItems)
	}
}
