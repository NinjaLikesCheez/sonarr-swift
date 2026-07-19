import Foundation

/// An error returned by the Sonarr server.
public enum SonarrResponseError: Error, Sendable {
	/// An error containing a message.
	case message(String?)
	/// The `X-Api-Key` header was missing or the API key was not valid (HTTP 401).
	case unauthorized
	/// The requested resource does not exist (HTTP 404).
	case notFound(message: String?)
	/// The request was rejected as invalid (HTTP 400); carries the field-level failures Sonarr reported.
	case validation([ValidationFailure])
	/// The server returned an unexpected non-2xx status code.
	case statusCode(Int, message: String?)
	/// An untyped `Error`.
	case unknown(Error)
}
