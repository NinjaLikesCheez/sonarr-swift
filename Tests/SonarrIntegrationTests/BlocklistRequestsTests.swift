import Sonarr
import Testing

@Suite("Blocklist Requests", .serialized)
struct BlocklistRequestsTests {
	@Test
	func test_blocklist() async throws {
		let page = try await client.request(.blocklist())

		#expect(page.page == 1)
	}

	@Test
	func test_deleteBlocklistEntry_notFound() async throws {
		await #expect(throws: (Sonarr.Error).self) {
			try await client.request(.deleteBlocklistEntry(id: Int.max))
		}
	}

	@Test
	func test_deleteBlocklistEntries_empty() async throws {
		try await client.request(.deleteBlocklistEntries(ids: []))
	}
}
