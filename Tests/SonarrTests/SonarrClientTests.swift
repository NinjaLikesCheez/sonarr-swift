import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("Response validation")
struct ValidationTests {
	let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	/// Runs the client's `validate` closure against a synthesized response and returns the thrown error, if any.
	private func validate(statusCode: Int, body: String = "") -> Sonarr.Error? {
		let response = HTTPURLResponse(
			url: URL(string: "http://localhost:8989/api/v3/series")!,
			statusCode: statusCode,
			httpVersion: nil,
			headerFields: nil
		)!

		do {
			try client.validate(Data(body.utf8), response)
			return nil
		} catch {
			return error
		}
	}

	@Test func successStatusCodesPass() {
		#expect(validate(statusCode: 200) == nil)
		#expect(validate(statusCode: 201, body: #"{"id": 1}"#) == nil)
	}

	@Test func unauthorizedIsTyped() throws {
		let error = try #require(validate(statusCode: 401))

		guard case .response(.unauthorized) = error else {
			Issue.record("Expected .response(.unauthorized), got \(error)")
			return
		}
	}

	@Test func notFoundCarriesMessage() throws {
		let error = try #require(validate(statusCode: 404, body: #"{"message": "NotFound"}"#))

		guard case .response(.notFound(message: "NotFound")) = error else {
			Issue.record("Expected .response(.notFound), got \(error)")
			return
		}
	}

	@Test func badRequestCarriesValidationFailures() throws {
		let body = #"[{"propertyName": "RootFolderPath", "errorMessage": "Path is invalid", "severity": "error"}]"#
		let error = try #require(validate(statusCode: 400, body: body))

		guard case let .response(.validation(failures)) = error else {
			Issue.record("Expected .response(.validation), got \(error)")
			return
		}

		#expect(failures.count == 1)
		#expect(failures.first?.propertyName == "RootFolderPath")
		#expect(failures.first?.errorMessage == "Path is invalid")
		#expect(failures.first?.severity == "error")
	}

	@Test func badRequestWithoutFailuresFallsBackToStatusCode() throws {
		let error = try #require(validate(statusCode: 400, body: #"{"message": "Bad Request"}"#))

		guard case .response(.statusCode(400, message: "Bad Request")) = error else {
			Issue.record("Expected .response(.statusCode(400)), got \(error)")
			return
		}
	}

	@Test func serverErrorCarriesStatusCodeAndMessage() throws {
		let error = try #require(validate(statusCode: 500, body: #"{"message": "Boom", "description": "It broke"}"#))

		guard case .response(.statusCode(500, message: "Boom")) = error else {
			Issue.record("Expected .response(.statusCode(500)), got \(error)")
			return
		}
	}

	@Test func nonJSONBodyIsSurfacedRaw() throws {
		let error = try #require(validate(statusCode: 503, body: "Service Unavailable"))

		guard case .response(.statusCode(503, message: "Service Unavailable")) = error else {
			Issue.record("Expected .response(.statusCode(503)), got \(error)")
			return
		}
	}
}

@Suite("Date decoding")
struct DateDecodingTests {
	let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private struct Dated: Decodable {
		let date: Date
	}

	@Test func decodesISO8601WithoutFractionalSeconds() throws {
		let decoded = try client.decoder.decode(Dated.self, from: Data(#"{"date": "2024-03-13T02:00:00Z"}"#.utf8))
		#expect(decoded.date == Date(timeIntervalSince1970: 1_710_295_200))
	}

	@Test func decodesISO8601WithFractionalSeconds() throws {
		let decoded = try client.decoder.decode(Dated.self, from: Data(#"{"date": "2024-03-13T02:00:00.123Z"}"#.utf8))
		#expect(abs(decoded.date.timeIntervalSince1970 - 1_710_295_200.123) < 0.001)
	}

	@Test func rejectsNonISO8601Dates() {
		#expect(throws: DecodingError.self) {
			try client.decoder.decode(Dated.self, from: Data(#"{"date": "13/03/2024"}"#.utf8))
		}
	}
}
