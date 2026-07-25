import Sonarr
import Testing

@Suite("Parse Requests", .serialized)
struct ParseRequestsTests {
	@Test
	func test_parse() async throws {
		let parsed = try await client.request(.parse(title: "Some.Show.S01E02.1080p.WEB.h264-GROUP"))

		#expect(parsed.parsedEpisodeInfo?.seriesTitle == "Some Show")
		#expect(parsed.parsedEpisodeInfo?.seasonNumber == 1)
		#expect(parsed.parsedEpisodeInfo?.episodeNumbers == [2])
	}
}
