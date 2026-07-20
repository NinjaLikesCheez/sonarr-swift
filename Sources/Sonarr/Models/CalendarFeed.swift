/// An iCalendar (`.ics`) document describing upcoming and recent episode air dates.
public struct CalendarFeed: Equatable, Decodable, Sendable {
	/// The raw iCalendar document content.
	public let icsContent: String
}
