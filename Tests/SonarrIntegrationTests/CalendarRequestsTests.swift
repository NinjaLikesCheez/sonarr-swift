import Foundation
import Sonarr
import Testing

@Suite("Calendar Requests", .serialized)
struct CalendarRequestsTests {
	@Test
	func test_calendar() async throws {
		let episodes = try await client.request(
			.calendar(start: Date().addingTimeInterval(-86400 * 7), end: Date().addingTimeInterval(86400 * 7))
		)

		#expect(episodes.allSatisfy { $0.seriesId > 0 })
	}

	@Test
	func test_calendarEntry_notFound() async throws {
		await #expect(throws: (Sonarr.Error).self) {
			try await client.request(.calendarEntry(id: Int.max))
		}
	}
}
