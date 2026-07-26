import Sonarr
import Testing

@Suite("UiConfig Requests", .serialized)
struct UiConfigRequestsTests {
	@Test
	func test_uiConfig_uiConfigById_updateUiConfig() async throws {
		let config = try await client.request(.uiConfig)
		let id = try #require(config.id)

		let fetched = try await client.request(.uiConfig(id: id))
		#expect(fetched.id == id)

		let toggled = UiConfigResource(
			id: id,
			firstDayOfWeek: config.firstDayOfWeek,
			calendarWeekColumnHeader: config.calendarWeekColumnHeader,
			shortDateFormat: config.shortDateFormat,
			longDateFormat: config.longDateFormat,
			timeFormat: config.timeFormat,
			showRelativeDates: !(config.showRelativeDates ?? false),
			enableColorImpairedMode: config.enableColorImpairedMode,
			theme: config.theme,
			uiLanguage: config.uiLanguage
		)

		let updated = try await client.request(.updateUiConfig(id: id, toggled))
		#expect(updated.showRelativeDates == !(config.showRelativeDates ?? false))

		// Restore the original value so this test doesn't leave the server's config mutated for other runs.
		_ = try await client.request(.updateUiConfig(id: id, config))
	}
}
