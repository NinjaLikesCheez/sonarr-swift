import Sonarr
import Testing

@Suite("ManualImport Requests", .serialized)
struct ManualImportRequestsTests {
	@Test
	func test_manualImport() async throws {
		// /config has no importable media, so this always returns an empty list on a fresh server -
		// the meaningful assertion here is that the response decodes, not its contents.
		let manualImports = try await client.request(.manualImport(folder: "/config"))
		#expect(manualImports.isEmpty)
	}

	@Test
	func test_manualImport_reprocessEmpty() async throws {
		try await client.request(.manualImport([]))
	}
}
