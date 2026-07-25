import Sonarr
import Testing

@Suite("LogFile Requests", .serialized)
struct LogFileRequestsTests {
	@Test
	func test_logFiles_logFile() async throws {
		let files = try await client.request(.logFiles)
		let file = try #require(files.first)
		let filename = try #require(file.filename)

		let contents = try await client.request(.logFile(filename: filename))
		#expect(!contents.isEmpty)
	}
}
