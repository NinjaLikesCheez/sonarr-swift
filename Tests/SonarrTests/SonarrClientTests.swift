import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("Response validation")
struct ValidationTests {
	let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	/// Runs the client's `validate` closure against a synthesized response and returns the typed response
	/// error, if any. `Sonarr.Error` itself isn't `Equatable` (it wraps types from `swift-api-client` that
	/// carry untyped `Error` payloads), but `SonarrResponseError` is - extracting it here lets call sites
	/// compare directly instead of pattern-matching with `guard case`.
	private func validate(statusCode: Int, body: String = "") -> SonarrResponseError? {
		let response = HTTPURLResponse(
			url: URL(string: "http://localhost:8989/api/v3/series")!,
			statusCode: statusCode,
			httpVersion: nil,
			headerFields: nil
		)!

		do {
			try client.validate(Data(body.utf8), response)
			return nil
		} catch .response(let responseError) {
			return responseError
		} catch {
			Issue.record("Expected .response(_), got \(error)")
			return nil
		}
	}

	@Test func successStatusCodesPass() {
		#expect(validate(statusCode: 200) == nil)
		#expect(validate(statusCode: 201, body: #"{"id": 1}"#) == nil)
	}

	@Test func unauthorizedIsTyped() {
		#expect(validate(statusCode: 401) == .unauthorized)
	}

	@Test func forbiddenCarriesMessage() {
		#expect(validate(statusCode: 403, body: #"{"message": "Forbidden"}"#) == .forbidden(message: "Forbidden"))
	}

	@Test func notFoundCarriesMessage() {
		#expect(validate(statusCode: 404, body: #"{"message": "NotFound"}"#) == .notFound(message: "NotFound"))
	}

	@Test func badRequestCarriesValidationFailures() throws {
		let body = #"[{"propertyName": "RootFolderPath", "errorMessage": "Path is invalid", "severity": "error"}]"#
		let expectedFailures = try JSONDecoder().decode([ValidationFailure].self, from: Data(body.utf8))

		#expect(validate(statusCode: 400, body: body) == .validation(expectedFailures))
	}

	@Test func badRequestWithoutFailuresFallsBackToStatusCode() {
		#expect(
			validate(statusCode: 400, body: #"{"message": "Bad Request"}"#)
				== .statusCode(400, message: "Bad Request")
		)
	}

	@Test func serverErrorCarriesStatusCodeAndMessage() {
		#expect(
			validate(statusCode: 500, body: #"{"message": "Boom", "description": "It broke"}"#)
				== .statusCode(500, message: "Boom")
		)
	}

	@Test func nonJSONBodyIsSurfacedRaw() {
		#expect(
			validate(statusCode: 503, body: "Service Unavailable")
				== .statusCode(503, message: "Service Unavailable")
		)
	}

	@Test func htmlBodyIsNotSurfacedAsAMessage() {
		let html = "<html><body><h1>502 Bad Gateway</h1></body></html>"

		#expect(validate(statusCode: 502, body: html) == .statusCode(502, message: nil))
	}
}

@Suite("Error descriptions")
struct ErrorDescriptionTests {
	@Test func notFoundUsesServerMessageWhenPresent() {
		let error = SonarrResponseError.notFound(message: "Series not found")
		#expect(error.errorDescription == "Series not found")
	}

	@Test func notFoundFallsBackToAGenericMessageWhenTheServerDidntSendOne() {
		let error = SonarrResponseError.notFound(message: nil)
		#expect(error.errorDescription == "The requested resource does not exist.")
	}

	@Test func validationJoinsFieldLevelMessages() throws {
		let body = #"""
			[
				{"propertyName": "RootFolderPath", "errorMessage": "Path is invalid", "severity": "error"},
				{"propertyName": "QualityProfileId", "errorMessage": "must be set", "severity": "error"}
			]
			"""#
		let failures = try JSONDecoder().decode([ValidationFailure].self, from: Data(body.utf8))
		let error = SonarrResponseError.validation(failures)

		#expect(error.errorDescription == "Path is invalid; must be set")
	}

	// Sonarr.validate never constructs .validation with an empty array (it only throws .validation after
	// checking !failures.isEmpty), but the case is public, so a directly-constructed empty array shouldn't
	// produce a blank description.
	@Test func validationWithNoFailuresFallsBackToAGenericMessage() {
		let error = SonarrResponseError.validation([])
		#expect(error.errorDescription == "The request was rejected as invalid.")
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
