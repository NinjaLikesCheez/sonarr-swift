import Sonarr
import Testing

@Suite("Update Requests", .serialized)
struct UpdateRequestsTests {
	@Test
	func test_updates() async throws {
		let updates = try await client.request(.updates)

		// The container image always ships with at least its own installed version in the update history.
		#expect(!updates.isEmpty)
		#expect(updates.contains(where: { $0.installed == true }))
	}
}
