import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("ApiInfo requests")
struct ApiInfoRequestsTests {
	@Test func apiInfoRequestConstruction() {
		let request = SonarrRequest.apiInfo

		#expect(request.method == .get)
		#expect(request.path == "api")
	}

	@Test func apiInfoDecoding() throws {
		let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")
		let json = Data(#"{"current": "v3", "deprecated": []}"#.utf8)

		let apiInfo = try client.decoder.decode(ApiInfo.self, from: json)

		#expect(apiInfo.current == "v3")
		#expect(apiInfo.deprecated.isEmpty)
	}

	@Test func apiInfoDecodingWithDeprecatedVersions() throws {
		let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")
		let json = Data(#"{"current": "v3", "deprecated": ["v1", "v2"]}"#.utf8)

		let apiInfo = try client.decoder.decode(ApiInfo.self, from: json)

		#expect(apiInfo.current == "v3")
		#expect(apiInfo.deprecated == ["v1", "v2"])
	}
}
