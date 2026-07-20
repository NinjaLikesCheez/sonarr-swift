import Sonarr
import Testing

@Suite("Backup Requests", .serialized)
struct BackupRequestsTests {
	@Test
	func test_backups() async throws {
		let backups = try await client.request(.backups)
		#expect(backups.allSatisfy { !$0.name.isEmpty })
	}
}
