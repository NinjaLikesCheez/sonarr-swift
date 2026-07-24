import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("IndexerFlag requests")
struct IndexerFlagRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	@Test func indexerFlagsRequestConstruction() {
		let request = SonarrRequest.indexerFlags

		#expect(request.method == .get)
		#expect(request.path == "api/v3/indexerflag")
	}

	@Test func indexerFlagResourceListDecoding() throws {
		let json = Data(
			#"""
			[
				{
					"id": 1,
					"name": "Freeleech",
					"nameLower": "freeleech"
				}
			]
			"""#.utf8
		)

		let flags = try client.decoder.decode([IndexerFlagResource].self, from: json)

		#expect(flags.count == 1)

		let flag = try #require(flags.first)
		#expect(flag.id == 1)
		#expect(flag.name == "Freeleech")
		#expect(flag.nameLower == "freeleech")
	}

	@Test func indexerFlagResourceDecodingWithNullableFields() throws {
		let json = Data(
			#"""
			{
				"id": 2,
				"name": null,
				"nameLower": null
			}
			"""#.utf8
		)

		let flag = try client.decoder.decode(IndexerFlagResource.self, from: json)

		#expect(flag.id == 2)
		#expect(flag.name == nil)
		#expect(flag.nameLower == nil)
	}
}
