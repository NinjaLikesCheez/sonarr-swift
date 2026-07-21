import Sonarr
import Testing

@Suite("Cutoff Requests", .serialized)
struct CutoffRequestsTests {
	@Test
	func test_cutoff() async throws {
		let page = try await client.request(.cutoff())

		#expect(page.page == 1)
	}

	@Test
	func test_cutoffEntry_notFound() async throws {
		await #expect(throws: (Sonarr.Error).self) {
			try await client.request(.cutoffEntry(id: Int.max))
		}
	}
}
