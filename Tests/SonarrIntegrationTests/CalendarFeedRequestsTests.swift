import Sonarr
import Testing

@Suite("CalendarFeed Requests", .serialized)
struct CalendarFeedRequestsTests {
	@Test
	func test_calendarFeed() async throws {
		let feed = try await client.request(.calendarFeed())

		#expect(feed.icsContent.contains("BEGIN:VCALENDAR"))
	}
}
