/// A field-level validation failure reported by Sonarr for a rejected request.
public struct ValidationFailure: Equatable, Decodable, Sendable {
	/// The name of the property that failed validation.
	public let propertyName: String?
	/// The human-readable reason the property failed validation.
	public let errorMessage: String?
	/// A machine-readable code identifying the kind of failure.
	public let errorCode: String?
	/// The severity Sonarr assigned to the failure, e.g. `error` or `warning`.
	public let severity: String?
}
