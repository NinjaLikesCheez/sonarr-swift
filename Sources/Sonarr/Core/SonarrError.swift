import Foundation

/// An error returned by the Sonarr server.
public enum SonarrResponseError: Error, Equatable, Sendable {
	/// The `X-Api-Key` header was missing or the API key was not valid (HTTP 401).
	case unauthorized
	/// The API key was valid but lacked permission to perform the request (HTTP 403).
	case forbidden(message: String?)
	/// The requested resource does not exist (HTTP 404).
	case notFound(message: String?)
	/// The request was rejected as invalid (HTTP 400); carries the field-level failures Sonarr reported.
	case validation([ValidationFailure])
	/// The server returned an unexpected non-2xx status code.
	case statusCode(Int, message: String?)
}

extension SonarrResponseError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case .unauthorized:
			return "The API key was missing or invalid."
		case .forbidden(let message):
			return message ?? "The API key did not have permission to perform this request."
		case .notFound(let message):
			return message ?? "The requested resource does not exist."
		case .validation(let failures):
			let messages = failures.compactMap(\.errorMessage).joined(separator: "; ")
			return messages.isEmpty ? "The request was rejected as invalid." : messages
		case .statusCode(let statusCode, let message):
			return message ?? "The server returned an unexpected status code: \(statusCode)."
		}
	}
}
