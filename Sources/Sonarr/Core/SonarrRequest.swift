import APIClient
import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public struct SonarrRequest<SonarrResponse: Decodable>: Request {
	public typealias Response = SonarrResponse
	public var method: HTTPMethod
	public var path: String?
	public var headers: HTTPFields
	public var body: () throws -> RequestBody?
	public var prepare: (URLRequest) -> URLRequest
	public var transform: ((Data, HTTPURLResponse) throws -> Response)?

	/// Creates a request against a Sonarr endpoint.
	///
	/// - Parameters:
	///   - method: The HTTP method of the endpoint.
	///   - path: The path of the endpoint relative to the server root, e.g. `api/v3/series`.
	///   - queryItems: Query parameters appended to the URL.
	///   - body: A closure producing the request body, if the endpoint takes one.
	///   - transform: An optional transform applied to the response data instead of the default decode.
	public init(
		method: HTTPMethod,
		path: String,
		queryItems: [URLQueryItem] = [],
		body: @escaping () throws -> RequestBody? = { nil },
		transform: ((Data, HTTPURLResponse) throws -> Response)? = nil
	) {
		self.method = method
		self.path = path
		headers = [:]
		self.body = body
		prepare = { Self.appendingQueryItems(queryItems, to: $0) }
		self.transform = transform
	}

	private static func appendingQueryItems(_ queryItems: [URLQueryItem], to request: URLRequest) -> URLRequest {
		guard !queryItems.isEmpty,
			let url = request.url,
			var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
		else {
			return request
		}

		components.queryItems = (components.queryItems ?? []) + queryItems

		var request = request
		request.url = components.url ?? url
		return request
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Creates a request for an endpoint whose response body is empty or irrelevant.
	///
	/// Sonarr returns empty bodies for most `DELETE`/command-style endpoints, which the default JSON
	/// decode would reject - this overload ignores the response body entirely.
	///
	/// - Parameters:
	///   - method: The HTTP method of the endpoint.
	///   - path: The path of the endpoint relative to the server root, e.g. `api/v3/series/1`.
	///   - queryItems: Query parameters appended to the URL.
	///   - body: A closure producing the request body, if the endpoint takes one.
	init(
		method: HTTPMethod,
		path: String,
		queryItems: [URLQueryItem] = [],
		body: @escaping () throws -> RequestBody? = { nil }
	) {
		self.init(method: method, path: path, queryItems: queryItems, body: body) { _, _ in EmptyResponse() }
	}
}
