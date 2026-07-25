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
		let decoded = try client.decoder.decode(SeasonPassResource.self, from: try body.encode())
		#expect(decoded == sampleSeasonPass)
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
