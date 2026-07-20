import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("CalendarFeed requests")
struct CalendarFeedRequestsTests {
	private func preparedURL(for request: SonarrRequest<CalendarFeed>) -> String? {
		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/\(request.path!)")!)
		return request.prepare(urlRequest).url?.absoluteString
	}

	@Test func calendarFeedUsesDefaultQueryItems() {
		let request = SonarrRequest.calendarFeed()

		#expect(request.method == .get)
		#expect(request.path == "feed/v3/calendar/sonarr.ics")
		#expect(
			preparedURL(for: request)
				== "http://localhost:8989/feed/v3/calendar/sonarr.ics?pastDays=7&futureDays=28&unmonitored=false"
				+ "&premieresOnly=false&asAllDay=false"
		)
	}

	@Test func calendarFeedOmitsTagsQueryItemWhenEmpty() {
		let request = SonarrRequest.calendarFeed(tags: [])

		#expect(preparedURL(for: request)?.contains("tags=") == false)
	}

	@Test func calendarFeedIncludesCommaSeparatedTags() {
		let request = SonarrRequest.calendarFeed(tags: [1, 2, 3])

		#expect(preparedURL(for: request)?.contains("tags=1,2,3") == true)
	}

	@Test func calendarFeedIncludesCustomValues() {
		let request = SonarrRequest.calendarFeed(
			pastDays: 1,
			futureDays: 2,
			unmonitored: true,
			premieresOnly: true,
			asAllDay: true
		)

		let url = preparedURL(for: request)
		#expect(url?.contains("pastDays=1") == true)
		#expect(url?.contains("futureDays=2") == true)
		#expect(url?.contains("unmonitored=true") == true)
		#expect(url?.contains("premieresOnly=true") == true)
		#expect(url?.contains("asAllDay=true") == true)
	}

	@Test func calendarFeedTransformDecodesRawTextAsICSContent() throws {
		let request = SonarrRequest.calendarFeed()
		let transform = try #require(request.transform)

		let response = HTTPURLResponse(
			url: URL(string: "http://localhost:8989/feed/v3/calendar/sonarr.ics")!,
			statusCode: 200,
			httpVersion: nil,
			headerFields: nil
		)!

		let ics = "BEGIN:VCALENDAR\nEND:VCALENDAR"
		let feed = try transform(Data(ics.utf8), response)

		#expect(feed.icsContent == ics)
	}
}
