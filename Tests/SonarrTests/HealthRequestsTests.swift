import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("Health requests")
struct HealthRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	@Test func healthRequestConstruction() {
		let request = SonarrRequest.health

		#expect(request.method == .get)
		#expect(request.path == "api/v3/health")
	}

	@Test func healthResourceListDecoding() throws {
		let json = Data(
			#"""
			[
				{
					"source": "UpdateCheck",
					"type": "warning",
					"message": "New update is available",
					"wikiUrl": "https://wiki.servarr.com/sonarr/system#updating",
					"id": 1
				}
			]
			"""#.utf8
		)

		let healthChecks = try client.decoder.decode([HealthResource].self, from: json)

		#expect(healthChecks.count == 1)

		let healthCheck = try #require(healthChecks.first)
		#expect(healthCheck.id == 1)
		#expect(healthCheck.source == "UpdateCheck")
		#expect(healthCheck.type == .warning)
		#expect(healthCheck.message == "New update is available")
		#expect(healthCheck.wikiUrl == "https://wiki.servarr.com/sonarr/system#updating")
	}

	@Test func healthResourceDecodingWithNullableFields() throws {
		let json = Data(
			#"""
			{
				"id": 2,
				"source": null,
				"type": "ok",
				"message": null,
				"wikiUrl": null
			}
			"""#.utf8
		)

		let healthCheck = try client.decoder.decode(HealthResource.self, from: json)

		#expect(healthCheck.id == 2)
		#expect(healthCheck.source == nil)
		#expect(healthCheck.type == .ok)
		#expect(healthCheck.message == nil)
		#expect(healthCheck.wikiUrl == nil)
	}

	// Sonarr's live server omits `id` entirely from health check entries, despite the OpenAPI
	// spec marking it required.
	@Test func healthResourceDecodingWithMissingId() throws {
		let json = Data(
			#"""
			{
				"source": "UpdateCheck",
				"type": "warning",
				"message": "New update is available",
				"wikiUrl": null
			}
			"""#.utf8
		)

		let healthCheck = try client.decoder.decode(HealthResource.self, from: json)

		#expect(healthCheck.id == nil)
		#expect(healthCheck.source == "UpdateCheck")
		#expect(healthCheck.type == .warning)
	}

	@Test func healthCheckResultDecodesAllCases() throws {
		for (raw, expected) in [
			("ok", HealthCheckResult.ok), ("notice", .notice), ("warning", .warning), ("error", .error),
		] {
			let json = Data("\"\(raw)\"".utf8)
			let decoded = try client.decoder.decode(HealthCheckResult.self, from: json)
			#expect(decoded == expected)
		}
	}
}
