import Sonarr
import Testing

@Suite("Health Requests", .serialized)
struct HealthRequestsTests {
	@Test
	func test_health() async throws {
		// A freshly-provisioned Sonarr instance may report zero or more health checks depending
		// on its configuration, so we only assert the request succeeds and decodes.
		_ = try await client.request(.health)
	}
}
