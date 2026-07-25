import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("Ping requests")
struct PingRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	@Test func pingRequestConstruction() {
		let request = SonarrRequest.ping

		#expect(request.method == .get)
		#expect(request.path == "ping")
	}

	@Test func pingResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"status": "OK"
			}
			"""#.utf8
		)

		let ping = try client.decoder.decode(PingResource.self, from: json)

		#expect(ping.status == "OK")
	}

	@Test func pingResourceDecodingWithNullableFields() throws {
		let json = Data(
			#"""
			{
				"status": null
			}
			"""#.utf8
		)

		let ping = try client.decoder.decode(PingResource.self, from: json)

		#expect(ping.status == nil)
	}
}
