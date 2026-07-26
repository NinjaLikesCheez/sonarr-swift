import Sonarr
import Testing

// `shutdownSystem`/`restartSystem` are intentionally not covered here: they'd kill the shared
// Sonarr instance every other integration test suite depends on, and this test target has no
// mechanism to guarantee they run last (or in their own isolated instance).
@Suite("System Requests", .serialized)
struct SystemRequestsTests {
	@Test
	func test_systemStatus() async throws {
		let status = try await client.request(.systemStatus)

		#expect(status.appName == "Sonarr")
	}

	@Test
	func test_systemRoutes() async throws {
		let routes = try await client.request(.systemRoutes)

		#expect(!routes.isEmpty)
	}

	@Test
	func test_systemDuplicateRoutes() async throws {
		try await client.request(.systemDuplicateRoutes)
	}
}
