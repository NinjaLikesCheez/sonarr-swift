import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("ImportListExclusion requests")
struct ImportListExclusionRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleExclusion: ImportListExclusionResource {
		ImportListExclusionResource(id: 1, tvdbId: 12345, title: "Some Show")
	}

	@available(*, deprecated)
	@Test func importListExclusionsRequestConstruction() {
		let request = SonarrRequest.importListExclusions

		#expect(request.method == .get)
		#expect(request.path == "api/v3/importlistexclusion")
	}

	@Test func importListExclusionsPagedRequestConstructionWithNoFilters() {
		let request = SonarrRequest.importListExclusions()

		#expect(request.method == .get)
		#expect(request.path == "api/v3/importlistexclusion/paged")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/importlistexclusion/paged")!)
		let prepared = request.prepare(urlRequest)

		#expect(prepared.url?.absoluteString == "http://localhost:8989/api/v3/importlistexclusion/paged")
	}

	@Test func importListExclusionsPagedRequestConstructionWithFilters() {
		let request = SonarrRequest.importListExclusions(
			page: 2,
			pageSize: 25,
			sortKey: "title",
			sortDirection: .descending
		)

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/importlistexclusion/paged")!)
		let prepared = request.prepare(urlRequest)

		#expect(
			prepared.url?.absoluteString
				== "http://localhost:8989/api/v3/importlistexclusion/paged?page=2&pageSize=25&sortKey=title&sortDirection=descending"
		)
	}

	@Test func importListExclusionRequestConstruction() {
		let request = SonarrRequest.importListExclusion(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/importlistexclusion/1")
	}

	@Test func addImportListExclusionRequestConstruction() throws {
		let request = SonarrRequest.addImportListExclusion(sampleExclusion)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/importlistexclusion")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(ImportListExclusionResource.self, from: try body.encode())
		#expect(decoded == sampleExclusion)
	}

	@Test func updateImportListExclusionRequestConstruction() throws {
		let request = SonarrRequest.updateImportListExclusion(id: 1, sampleExclusion)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/importlistexclusion/1")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(ImportListExclusionResource.self, from: try body.encode())
		#expect(decoded == sampleExclusion)
	}

	@Test func deleteImportListExclusionRequestConstruction() {
		let request = SonarrRequest.deleteImportListExclusion(id: 1)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/importlistexclusion/1")
	}

	@Test func deleteImportListExclusionsRequestConstruction() throws {
		let bulkResource = ImportListExclusionBulkResource(ids: [1, 2, 3])
		let request = SonarrRequest.deleteImportListExclusions(bulkResource)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/importlistexclusion/bulk")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: [Int]])

		#expect(json["ids"] == [1, 2, 3])
	}

	@Test func importListExclusionResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"tvdbId": 12345,
				"title": "Some Show"
			}
			"""#.utf8
		)

		let exclusion = try client.decoder.decode(ImportListExclusionResource.self, from: json)

		#expect(exclusion.id == 1)
		#expect(exclusion.tvdbId == 12345)
		#expect(exclusion.title == "Some Show")
	}

	@Test func importListExclusionPageDecoding() throws {
		let json = Data(
			#"""
			{
				"page": 1,
				"pageSize": 10,
				"sortKey": "title",
				"sortDirection": "ascending",
				"totalRecords": 1,
				"records": [
					{
						"id": 1,
						"tvdbId": 12345,
						"title": "Some Show"
					}
				]
			}
			"""#.utf8
		)

		let page = try client.decoder.decode(PagingResource<ImportListExclusionResource>.self, from: json)

		#expect(page.page == 1)
		#expect(page.totalRecords == 1)
		#expect(page.records == [ImportListExclusionResource(id: 1, tvdbId: 12345, title: "Some Show")])
	}
}
