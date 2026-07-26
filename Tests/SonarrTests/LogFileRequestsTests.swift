import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("LogFile requests")
struct LogFileRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	@Test func logFilesRequestConstruction() {
		let request = SonarrRequest.logFiles

		#expect(request.method == .get)
		#expect(request.path == "api/v3/log/file")
	}

	@Test func logFileRequestConstruction() {
		let request = SonarrRequest.logFile(filename: "sonarr.txt")

		#expect(request.method == .get)
		#expect(request.path == "api/v3/log/file/sonarr.txt")
	}

	@Test func logFileTransformDecodesRawTextAsString() throws {
		let request = SonarrRequest.logFile(filename: "sonarr.txt")
		let transform = try #require(request.transform)

		let response = HTTPURLResponse(
			url: URL(string: "http://localhost:8989/api/v3/log/file/sonarr.txt")!,
			statusCode: 200,
			httpVersion: nil,
			headerFields: nil
		)!

		let contents = "2024-01-01 12:00:00.0|Info|Sonarr.Api|Starting up"
		let decoded = try transform(Data(contents.utf8), response)

		#expect(decoded == contents)
	}

	@Test func updateLogFilesRequestConstruction() {
		let request = SonarrRequest.updateLogFiles

		#expect(request.method == .get)
		#expect(request.path == "api/v3/log/file/update")
	}

	@Test func updateLogFileRequestConstruction() {
		let request = SonarrRequest.updateLogFile(filename: "update.1.txt")

		#expect(request.method == .get)
		#expect(request.path == "api/v3/log/file/update/update.1.txt")
	}

	@Test func updateLogFileTransformDecodesRawTextAsString() throws {
		let request = SonarrRequest.updateLogFile(filename: "update.1.txt")
		let transform = try #require(request.transform)

		let response = HTTPURLResponse(
			url: URL(string: "http://localhost:8989/api/v3/log/file/update/update.1.txt")!,
			statusCode: 200,
			httpVersion: nil,
			headerFields: nil
		)!

		let contents = "2024-01-01 12:00:00.0|Info|Sonarr.Update|Starting update"
		let decoded = try transform(Data(contents.utf8), response)

		#expect(decoded == contents)
	}

	@Test func logFileResourceListDecoding() throws {
		let json = Data(
			#"""
			[
				{
					"id": 1,
					"filename": "sonarr.txt",
					"lastWriteTime": "2024-01-01T12:00:00Z",
					"contentsUrl": "/api/v3/log/file/sonarr.txt",
					"downloadUrl": "/api/v3/log/file/sonarr.txt"
				}
			]
			"""#.utf8
		)

		let files = try client.decoder.decode([LogFileResource].self, from: json)

		#expect(files.count == 1)

		let file = try #require(files.first)
		#expect(file.id == 1)
		#expect(file.filename == "sonarr.txt")
		#expect(file.lastWriteTime == Date(timeIntervalSince1970: 1_704_110_400))
		#expect(file.contentsUrl == "/api/v3/log/file/sonarr.txt")
		#expect(file.downloadUrl == "/api/v3/log/file/sonarr.txt")
	}

	@Test func logFileResourceDecodingWithNullableFields() throws {
		let json = Data(
			#"""
			{
				"id": 2,
				"filename": null,
				"lastWriteTime": "2024-01-01T12:00:00Z",
				"contentsUrl": null,
				"downloadUrl": null
			}
			"""#.utf8
		)

		let file = try client.decoder.decode(LogFileResource.self, from: json)

		#expect(file.filename == nil)
		#expect(file.contentsUrl == nil)
		#expect(file.downloadUrl == nil)
	}
}
