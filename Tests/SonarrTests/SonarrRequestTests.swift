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
