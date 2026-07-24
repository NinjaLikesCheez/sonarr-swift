import Sonarr
import Testing

@Suite("IndexerFlag Requests", .serialized)
struct IndexerFlagRequestsTests {
	@Test
	func test_indexerFlags() async throws {
		let flags = try await client.request(.indexerFlags)
		#expect(!flags.isEmpty)
	}
}
