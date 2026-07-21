import Foundation
import Sonarr
import Testing

@Suite("History Requests", .serialized)
struct HistoryRequestsTests {
	@Test
	func test_history() async throws {
		let page = try await client.request(.history())

		#expect(page.page == 1)
	}

	@Test
	func test_historySince() async throws {
		let events = try await client.request(.historySince(date: Date(timeIntervalSince1970: 0)))

		#expect(events.isEmpty)
	}

	@Test
	func test_historyForSeries_notFound() async throws {
		// No series exist to pull real identifiers from yet - filtering by a nonexistent series still
		// exercises the request/response shape without depending on seeded data. Sonarr validates
		// seriesId as an int32 (Int.max, an int64, is rejected with 400 instead) and 404s for an
		// id that doesn't correspond to a real series, rather than returning an empty list.
		await #expect(throws: (Sonarr.Error).self) {
			try await client.request(.historyForSeries(seriesId: Int(Int32.max)))
		}
	}

	@Test
	func test_markHistoryEventAsFailed_notFound() async throws {
		await #expect(throws: (Sonarr.Error).self) {
			try await client.request(.markHistoryEventAsFailed(id: Int.max))
		}
	}
}
