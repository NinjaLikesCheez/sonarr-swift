import Sonarr
import Testing

@Suite("Command Requests", .serialized)
struct CommandRequestsTests {
	@Test
	func test_rssSync_thenGetById_thenList() async throws {
		let queued = try await client.request(.rssSync)
		#expect(queued.name == "RssSync")

		let fetched = try await client.request(.command(id: queued.id))
		#expect(fetched.id == queued.id)

		let commands = try await client.request(.commands)
		#expect(commands.contains { $0.id == queued.id })
	}

	@Test
	func test_cancelCommand_notFound() async throws {
		await #expect(throws: (Sonarr.Error).self) {
			try await client.request(.cancelCommand(id: Int.max))
		}
	}
}
