import Sonarr
import Testing

@Suite("DiskSpace Requests", .serialized)
struct DiskSpaceRequestsTests {
	@Test
	func test_diskSpace() async throws {
		let diskSpaces = try await client.request(.diskSpace)
		#expect(!diskSpaces.isEmpty)
	}
}
