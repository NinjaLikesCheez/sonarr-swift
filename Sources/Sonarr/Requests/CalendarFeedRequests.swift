import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public extension SonarrRequest where SonarrResponse == CalendarFeed {
	/// Fetches an iCalendar feed of episode air dates, for subscribing to in a calendar app.
	///
	/// Endpoint: `GET /feed/v3/calendar/sonarr.ics`
	///
	/// Result: the iCalendar (`.ics`) document as raw text.
	///
	/// - Parameters:
	///   - pastDays: How many days in the past to include episodes from. Defaults to `7`.
	///   - futureDays: How many days in the future to include episodes from. Defaults to `28`.
	///   - tags: Tag IDs to filter series by. Series without any of these tags are excluded. Defaults to no filtering.
	///   - unmonitored: Whether to include episodes from unmonitored series/seasons. Defaults to `false`.
	///   - premieresOnly: Whether to only include season premieres (season 1 episode 1 of each series). Defaults to
	///     `false`.
	///   - asAllDay: Whether to represent episodes as all-day events instead of events with start/end times.
	///     Defaults to `false`.
	static func calendarFeed(
		pastDays: Int = 7,
		futureDays: Int = 28,
		tags: [Int] = [],
		unmonitored: Bool = false,
		premieresOnly: Bool = false,
		asAllDay: Bool = false
	) -> SonarrRequest<CalendarFeed> {
		var queryItems = [
			URLQueryItem(name: "pastDays", value: String(pastDays)),
			URLQueryItem(name: "futureDays", value: String(futureDays)),
			URLQueryItem(name: "unmonitored", value: String(unmonitored)),
			URLQueryItem(name: "premieresOnly", value: String(premieresOnly)),
			URLQueryItem(name: "asAllDay", value: String(asAllDay)),
		]

		if !tags.isEmpty {
			queryItems.append(URLQueryItem(name: "tags", value: tags.map(String.init).joined(separator: ",")))
		}

		return SonarrRequest(
			method: .get,
			path: "feed/v3/calendar/sonarr.ics",
			queryItems: queryItems,
			transform: { data, _ in
				CalendarFeed(icsContent: String(decoding: data, as: UTF8.self))
			}
		)
	}
}
