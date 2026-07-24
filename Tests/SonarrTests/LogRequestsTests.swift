import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("Log requests")
struct LogRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	@Test func logsRequestConstructionWithDefaults() {
		let request = SonarrRequest.logs()

		#expect(request.method == .get)
		#expect(request.path == "api/v3/log")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/log")!)
		let prepared = request.prepare(urlRequest)

		#expect(prepared.url?.absoluteString == "http://localhost:8989/api/v3/log")
	}

	@Test func logsRequestConstructionWithFilters() {
		let request = SonarrRequest.logs(
			page: 2, pageSize: 25, sortKey: "time", sortDirection: "descending", level: "error")

		#expect(request.method == .get)
		#expect(request.path == "api/v3/log")

		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/api/v3/log")!)
		let prepared = request.prepare(urlRequest)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)

		#expect(
			components?.queryItems == [
				URLQueryItem(name: "page", value: "2"),
				URLQueryItem(name: "pageSize", value: "25"),
				URLQueryItem(name: "sortKey", value: "time"),
				URLQueryItem(name: "sortDirection", value: "descending"),
				URLQueryItem(name: "level", value: "error"),
			]
		)
	}

	@Test func logResourcePagingResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"page": 1,
				"pageSize": 10,
				"sortKey": "time",
				"sortDirection": "descending",
				"totalRecords": 1,
				"records": [
					{
						"id": 1,
						"time": "2024-01-01T12:00:00Z",
						"exception": null,
						"exceptionType": null,
						"level": "info",
						"logger": "Sonarr.Api",
						"message": "Starting up",
						"method": null
					}
				]
			}
			"""#.utf8
		)

		let page = try client.decoder.decode(PagingResource<LogResource>.self, from: json)

		#expect(page.page == 1)
		#expect(page.records.count == 1)

		let log = try #require(page.records.first)
		#expect(log.id == 1)
		#expect(log.time == Date(timeIntervalSince1970: 1_704_110_400))
		#expect(log.level == "info")
		#expect(log.logger == "Sonarr.Api")
		#expect(log.message == "Starting up")
		#expect(log.exception == nil)
		#expect(log.exceptionType == nil)
		#expect(log.method == nil)
	}

	@Test func logResourceDecodingWithException() throws {
		let json = Data(
			#"""
			{
				"id": 2,
				"time": "2024-01-01T12:00:00Z",
				"exception": "Something went wrong",
				"exceptionType": "System.Exception",
				"level": "error",
				"logger": "Sonarr.Api",
				"message": "Request failed",
				"method": "GetSeries"
			}
			"""#.utf8
		)

		let log = try client.decoder.decode(LogResource.self, from: json)

		#expect(log.exception == "Something went wrong")
		#expect(log.exceptionType == "System.Exception")
		#expect(log.method == "GetSeries")
	}
}
