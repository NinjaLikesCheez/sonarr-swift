import Sonarr
import Testing

@Suite("ManualImport Requests", .serialized)
struct ManualImportRequestsTests {
	@Test
	func test_manualImport() async throws {
		_ = try await client.request(.manualImport(folder: "/config"))
	}

	@Test
	func test_manualImport_reprocessEmpty() async throws {
		try await client.request(.manualImport([]))
	}
}
