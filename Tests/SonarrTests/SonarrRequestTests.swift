import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("Request construction")
struct SonarrRequestTests {
	@Test func prepareAppendsQueryItems() {
		let request = SonarrRequest<EmptyResponse>(
			method: .get,
			path: "api/v3/series",
			queryItems: [
				URLQueryItem(name: "includeSeasonImages", value: "true"),
				URLQueryItem(name: "tvdbId", value: "12345"),
			]
		)

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/series")!)
		let prepared = request.prepare(urlRequest)

		#expect(prepared.url?.absoluteString == "http://localhost:8989/api/v3/series?includeSeasonImages=true&tvdbId=12345")
	}

	// ASP.NET Core (Sonarr's stack) decodes an unencoded `+` in a query string as a space, so `+` must be
	// percent-escaped like any other reserved character - assert both the escaped bytes on the wire and
	// that re-parsing the URL recovers the exact original value, for a query value containing `+`, `&`,
	// a space, and a non-ASCII character all at once.
	@Test func prepareEscapesPlusAmpersandSpaceAndNonASCIIInQueryValues() throws {
		let term = "C++ & Café"
		let request = SonarrRequest<EmptyResponse>(
			method: .get,
			path: "api/v3/series/lookup",
			queryItems: [URLQueryItem(name: "term", value: term)]
		)

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/series/lookup")!)
		let prepared = request.prepare(urlRequest)
		let url = try #require(prepared.url)

		#expect(url.absoluteString == "http://localhost:8989/api/v3/series/lookup?term=C%2B%2B%20%26%20Caf%C3%A9")

		let components = try #require(URLComponents(url: url, resolvingAgainstBaseURL: false))
		#expect(components.queryItems?.first(where: { $0.name == "term" })?.value == term)
	}

	@Test func prepareWithoutQueryItemsLeavesURLUntouched() {
		let request = SonarrRequest<EmptyResponse>(method: .get, path: "api/v3/health")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/health")!)
		let prepared = request.prepare(urlRequest)

		#expect(prepared.url?.absoluteString == "http://localhost:8989/api/v3/health")
	}

	@Test func emptyResponseRequestsIgnoreResponseBodies() throws {
		let request = SonarrRequest<EmptyResponse>(method: .delete, path: "api/v3/series/1")
		let transform = try #require(request.transform)

		let response = HTTPURLResponse(
			url: URL(string: "http://localhost:8989/api/v3/series/1")!,
			statusCode: 200,
			httpVersion: nil,
			headerFields: nil
		)!

		// Sonarr returns a completely empty body here, which the default JSON decode would reject.
		_ = try transform(Data(), response)
	}
}
