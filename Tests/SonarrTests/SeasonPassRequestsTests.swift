import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("SeasonPass requests")
struct SeasonPassRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleSeasonPass: SeasonPassResource {
		SeasonPassResource(
			series: [
				SeasonPassSeriesResource(
					id: 1,
					monitored: true,
					seasons: [SeasonResource(seasonNumber: 1, monitored: true)]
				)
			],
			monitoringOptions: MonitoringOptions(
				ignoreEpisodesWithFiles: false,
				ignoreEpisodesWithoutFiles: false,
				monitor: .all
			)
		)
	}

	@Test func updateSeasonPassRequestConstruction() throws {
		let request = SonarrRequest.updateSeasonPass(sampleSeasonPass)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/seasonpass")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		let series = try #require(json["series"] as? [[String: Any]])
		#expect(series.count == 1)
		#expect(series.first?["id"] as? Int == 1)
		#expect(series.first?["monitored"] as? Bool == true)

		let seasons = try #require(series.first?["seasons"] as? [[String: Any]])
		#expect(seasons.count == 1)
		#expect(seasons.first?["seasonNumber"] as? Int == 1)
		#expect(seasons.first?["monitored"] as? Bool == true)

		let monitoringOptions = try #require(json["monitoringOptions"] as? [String: Any])
		#expect(monitoringOptions["ignoreEpisodesWithFiles"] as? Bool == false)
		#expect(monitoringOptions["ignoreEpisodesWithoutFiles"] as? Bool == false)
		#expect(monitoringOptions["monitor"] as? String == "all")
	}

	@Test func seasonPassResourceEncodingWithNilFields() throws {
		let seasonPass = SeasonPassResource()
		let request = SonarrRequest.updateSeasonPass(seasonPass)

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["series"] == nil)
		#expect(json["monitoringOptions"] == nil)
	}
}
