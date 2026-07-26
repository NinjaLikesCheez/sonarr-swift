import Foundation
import Sonarr
import Testing

@Suite("PagingResource decoding")
struct PagingResourceTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	// Sonarr's spec marks sortKey and records nullable on every *PagingResource schema - sortKey is null
	// whenever no explicit sort was requested, a common, legal response shape. Before this fix, decoding
	// either as non-optional failed the whole page's decode, not just the missing field.
	@Test func decodesWithNullSortKeyAndNullRecords() throws {
		let json = Data(
			#"""
			{
				"page": 1,
				"pageSize": 10,
				"sortKey": null,
				"sortDirection": "default",
				"totalRecords": 0,
				"records": null
			}
			"""#.utf8
		)

		let page = try client.decoder.decode(PagingResource<TagResource>.self, from: json)

		#expect(page.page == 1)
		#expect(page.sortKey == nil)
		#expect(page.sortDirection == .default)
		#expect(page.records == nil)
	}

	@Test func decodesWithNonNullSortKeyAndRecords() throws {
		let json = Data(
			#"""
			{
				"page": 2,
				"pageSize": 10,
				"sortKey": "title",
				"sortDirection": "ascending",
				"totalRecords": 1,
				"records": [{"id": 1, "label": "some-tag"}]
			}
			"""#.utf8
		)

		let page = try client.decoder.decode(PagingResource<TagResource>.self, from: json)

		#expect(page.sortKey == "title")
		#expect(page.sortDirection == .ascending)
		#expect(page.records?.count == 1)
	}
}
