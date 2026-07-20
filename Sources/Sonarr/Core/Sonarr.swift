@_exported import APIClient
import Foundation
import Logging

// URLSession exists in FoundationNetworking on Linux
#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

/// A Sonarr v3 REST API client.
public final class Sonarr: Client, Sendable {
	public typealias ResponseError = SonarrResponseError
	public typealias Error = ClientError<ResponseError>

	/// The URL of the Sonarr server, e.g. `http://localhost:8989`.
	public let baseURL: URL
	/// The API key used to authenticate requests (Sonarr → Settings → General → Security).
	public let apiKey: String
	/// Basic authentication to be added to Authorization header.
	public let basicAuthentication: BasicAuthentication?
	public let defaultHeaders: APIClient.HTTPFields?

	public let decoder: JSONDecoder

	public let validate: @Sendable (Data, HTTPURLResponse) throws(APIClient.ClientError<SonarrResponseError>) -> Void

	public let prepare: @Sendable (URLRequest) -> URLRequest

	public let session: URLSession = .shared

	private let logger = Logger(label: "Sonarr")

	// ISO8601DateFormatter is documented as thread-safe, so sharing immutable instances across
	// concurrent decodes is fine even though the type isn't marked Sendable.
	nonisolated(unsafe) private static let iso8601Formatter: ISO8601DateFormatter = {
		let formatter = ISO8601DateFormatter()
		formatter.formatOptions = [.withInternetDateTime]
		return formatter
	}()

	nonisolated(unsafe) private static let iso8601FractionalFormatter: ISO8601DateFormatter = {
		let formatter = ISO8601DateFormatter()
		formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
		return formatter
	}()

	/// Creates a Sonarr client to interact with the given server URL.
	/// - Parameters:
	///   - baseURL: The URL of the Sonarr server, e.g. `http://localhost:8989`.
	///   - apiKey: The API key used to authenticate requests.
	///   - basicAuthentication: Optional basic authentication added to the Authorization header.
	public init(baseURL: URL, apiKey: String, basicAuthentication: BasicAuthentication? = nil) {
		self.baseURL = baseURL
		self.apiKey = apiKey
		self.basicAuthentication = basicAuthentication

		defaultHeaders = [
			"X-Api-Key": apiKey,
			"Content-Type": "application/json",
			"Accept": "application/json",
		]
		decoder = Self.makeDecoder()
		prepare = { $0 }
		validate = Self.validate
	}

	static func makeDecoder() -> JSONDecoder {
		let decoder = JSONDecoder()

		// Sonarr emits ISO 8601 timestamps both with and without fractional seconds (often .NET's
		// 7-digit precision), so `.iso8601` alone would reject half of them - try both shapes.
		decoder.dateDecodingStrategy = .custom { decoder in
			let container = try decoder.singleValueContainer()
			let value = try container.decode(String.self)

			if let date = iso8601FractionalFormatter.date(from: value) ?? iso8601Formatter.date(from: value) {
				return date
			}

			throw DecodingError.dataCorruptedError(
				in: container,
				debugDescription: "Expected an ISO 8601 date, got: \(value)"
			)
		}

		return decoder
	}

	@Sendable
	private static func validate(data: Data, response: HTTPURLResponse) throws(Sonarr.Error) {
		switch response.statusCode {
		case 200..<300:
			return
		case 400:
			// Sonarr reports request validation failures as a JSON array of field-level errors; fall back to
			// the plain error envelope when the body isn't in that shape.
			if let failures = try? JSONDecoder().decode([ValidationFailure].self, from: data), !failures.isEmpty {
				throw .response(.validation(failures))
			}

			throw .response(.statusCode(response.statusCode, message: errorMessage(from: data)))
		case 401:
			throw .response(.unauthorized)
		case 404:
			throw .response(.notFound(message: errorMessage(from: data)))
		case let statusCode:
			throw .response(.statusCode(statusCode, message: errorMessage(from: data)))
		}
	}

	/// Extracts a human-readable message from Sonarr's error envelope, falling back to the raw body.
	private static func errorMessage(from data: Data) -> String? {
		if let error = try? JSONDecoder().decode(ErrorResponse.self, from: data),
			let message = error.message ?? error.description
		{
			return message
		}

		guard !data.isEmpty else { return nil }

		return String(bytes: data, encoding: .utf8)
	}
}

/// Swift Concurrency powered extensions for `Sonarr`.
public extension Sonarr {
	/// Sends a request to the server.
	/// - Parameter request: The request to be sent to the server.
	/// - Returns: The decoded response value.
	@discardableResult
	func request<Value: Decodable>(_ request: SonarrRequest<Value>) async throws(Sonarr.Error) -> Value {
		try await send(request: request)
	}
}
