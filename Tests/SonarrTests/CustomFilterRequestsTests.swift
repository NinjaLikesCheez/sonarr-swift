import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("CustomFilter requests")
struct CustomFilterRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private let sampleCustomFilter = CustomFilterResource(
		id: 1,
		type: "series",
		label: "Continuing Anime",
		filters: [
			["key": .string("status"), "value": .string("continuing")],
			["key": .string("genres"), "value": .array([.string("Anime")])],
		]
	)

	@Test func customFiltersRequestConstruction() {
		let request = SonarrRequest.customFilters

		#expect(request.method == .get)
		#expect(request.path == "api/v3/customfilter")
	}

	@Test func customFilterRequestConstruction() {
		let request = SonarrRequest.customFilter(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/customfilter/1")
	}

	@Test func addCustomFilterRequestConstruction() throws {
		let request = SonarrRequest.addCustomFilter(sampleCustomFilter)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/customfilter")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(CustomFilterResource.self, from: try body.encode())
		#expect(decoded == sampleCustomFilter)
	}

	@Test func updateCustomFilterRequestConstruction() throws {
		let request = SonarrRequest.updateCustomFilter(id: 1, sampleCustomFilter)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/customfilter/1")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(CustomFilterResource.self, from: try body.encode())
		#expect(decoded == sampleCustomFilter)
	}

	@Test func deleteCustomFilterRequestConstruction() {
		let request = SonarrRequest.deleteCustomFilter(id: 1)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/customfilter/1")
	}

	@Test func customFilterResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"type": "series",
				"label": "Continuing Anime",
				"filters": [
					{
						"key": "status",
						"value": "continuing"
					},
					{
						"key": "genres",
						"value": ["Anime"]
					}
				]
			}
			"""#.utf8
		)

		let customFilter = try client.decoder.decode(CustomFilterResource.self, from: json)

		#expect(customFilter.id == 1)
		#expect(customFilter.type == "series")
		#expect(customFilter.label == "Continuing Anime")
		#expect(customFilter.filters?.count == 2)
		#expect(customFilter.filters?.first?["key"] == .string("status"))
		#expect(customFilter.filters?.first?["value"] == .string("continuing"))
		#expect(customFilter.filters?.last?["value"] == .array([.string("Anime")]))
	}

	@Test func customFilterResourceListDecoding() throws {
		let json = Data(
			#"""
			[
				{
					"id": 1,
					"type": "series",
					"label": "Continuing Anime",
					"filters": []
				}
			]
			"""#.utf8
		)

		let customFilters = try client.decoder.decode([CustomFilterResource].self, from: json)

		#expect(customFilters.count == 1)
		#expect(customFilters.first?.label == "Continuing Anime")
		#expect(customFilters.first?.filters?.isEmpty == true)
	}
}
