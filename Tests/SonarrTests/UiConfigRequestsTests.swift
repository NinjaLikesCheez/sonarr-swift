import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("UiConfig requests")
struct UiConfigRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleUiConfig: UiConfigResource {
		UiConfigResource(
			id: 1,
			firstDayOfWeek: 0,
			calendarWeekColumnHeader: "ddd M/D",
			shortDateFormat: "MMM D, YYYY",
			longDateFormat: "dddd, MMMM D, YYYY",
			timeFormat: "h(:mm)a",
			showRelativeDates: true,
			enableColorImpairedMode: false,
			theme: "auto",
			uiLanguage: 1
		)
	}

	@Test func uiConfigRequestConstruction() {
		let request = SonarrRequest.uiConfig

		#expect(request.method == .get)
		#expect(request.path == "api/v3/config/ui")
	}

	@Test func uiConfigByIdRequestConstruction() {
		let request = SonarrRequest.uiConfig(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/config/ui/1")
	}

	@Test func updateUiConfigRequestConstruction() throws {
		let request = SonarrRequest.updateUiConfig(id: 1, sampleUiConfig)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/config/ui/1")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["firstDayOfWeek"] as? Int == 0)
		#expect(json["calendarWeekColumnHeader"] as? String == "ddd M/D")
		#expect(json["shortDateFormat"] as? String == "MMM D, YYYY")
		#expect(json["longDateFormat"] as? String == "dddd, MMMM D, YYYY")
		#expect(json["timeFormat"] as? String == "h(:mm)a")
		#expect(json["showRelativeDates"] as? Bool == true)
		#expect(json["enableColorImpairedMode"] as? Bool == false)
		#expect(json["theme"] as? String == "auto")
		#expect(json["uiLanguage"] as? Int == 1)
	}

	@Test func uiConfigResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"firstDayOfWeek": 0,
				"calendarWeekColumnHeader": "ddd M/D",
				"shortDateFormat": "MMM D, YYYY",
				"longDateFormat": "dddd, MMMM D, YYYY",
				"timeFormat": "h(:mm)a",
				"showRelativeDates": true,
				"enableColorImpairedMode": false,
				"theme": "auto",
				"uiLanguage": 1
			}
			"""#.utf8
		)

		let config = try client.decoder.decode(UiConfigResource.self, from: json)

		#expect(config.id == 1)
		#expect(config.firstDayOfWeek == 0)
		#expect(config.calendarWeekColumnHeader == "ddd M/D")
		#expect(config.shortDateFormat == "MMM D, YYYY")
		#expect(config.longDateFormat == "dddd, MMMM D, YYYY")
		#expect(config.timeFormat == "h(:mm)a")
		#expect(config.showRelativeDates == true)
		#expect(config.enableColorImpairedMode == false)
		#expect(config.theme == "auto")
		#expect(config.uiLanguage == 1)
	}

	@Test func uiConfigResourceDecodingWithNullOptionalFields() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"firstDayOfWeek": 0,
				"calendarWeekColumnHeader": null,
				"shortDateFormat": null,
				"longDateFormat": null,
				"timeFormat": null,
				"showRelativeDates": false,
				"enableColorImpairedMode": false,
				"theme": null,
				"uiLanguage": 1
			}
			"""#.utf8
		)

		let config = try client.decoder.decode(UiConfigResource.self, from: json)

		#expect(config.calendarWeekColumnHeader == nil)
		#expect(config.shortDateFormat == nil)
		#expect(config.longDateFormat == nil)
		#expect(config.timeFormat == nil)
		#expect(config.theme == nil)
	}
}
