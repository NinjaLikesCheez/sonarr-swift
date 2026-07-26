/// The web UI display configuration for a Sonarr instance.
public struct UiConfigResource: Equatable, Codable, Sendable {
	/// The unique identifier of the UI configuration.
	public let id: Int?
	/// The day the calendar week starts on, as a .NET `DayOfWeek` value (`0` = Sunday).
	public let firstDayOfWeek: Int?
	/// The format used for the calendar's week column header.
	public let calendarWeekColumnHeader: String?
	/// The format used to display short dates.
	public let shortDateFormat: String?
	/// The format used to display long dates.
	public let longDateFormat: String?
	/// The format used to display times.
	public let timeFormat: String?
	/// Whether dates are shown relative to now, e.g. `Today`.
	public let showRelativeDates: Bool?
	/// Whether the color-impaired-friendly UI theme is enabled.
	public let enableColorImpairedMode: Bool?
	/// The UI theme.
	public let theme: String?
	/// The language the UI is displayed in, as a Sonarr language identifier.
	public let uiLanguage: Int?

	/// Creates a UI configuration to send to the server.
	/// - Parameters:
	///   - id: The unique identifier of the UI configuration.
	///   - firstDayOfWeek: The day the calendar week starts on, as a .NET `DayOfWeek` value (`0` = Sunday).
	///   - calendarWeekColumnHeader: The format used for the calendar's week column header.
	///   - shortDateFormat: The format used to display short dates.
	///   - longDateFormat: The format used to display long dates.
	///   - timeFormat: The format used to display times.
	///   - showRelativeDates: Whether dates are shown relative to now, e.g. `Today`.
	///   - enableColorImpairedMode: Whether the color-impaired-friendly UI theme is enabled.
	///   - theme: The UI theme.
	///   - uiLanguage: The language the UI is displayed in, as a Sonarr language identifier.
	public init(
		id: Int? = nil,
		firstDayOfWeek: Int? = nil,
		calendarWeekColumnHeader: String? = nil,
		shortDateFormat: String? = nil,
		longDateFormat: String? = nil,
		timeFormat: String? = nil,
		showRelativeDates: Bool? = nil,
		enableColorImpairedMode: Bool? = nil,
		theme: String? = nil,
		uiLanguage: Int? = nil
	) {
		self.id = id
		self.firstDayOfWeek = firstDayOfWeek
		self.calendarWeekColumnHeader = calendarWeekColumnHeader
		self.shortDateFormat = shortDateFormat
		self.longDateFormat = longDateFormat
		self.timeFormat = timeFormat
		self.showRelativeDates = showRelativeDates
		self.enableColorImpairedMode = enableColorImpairedMode
		self.theme = theme
		self.uiLanguage = uiLanguage
	}
}
