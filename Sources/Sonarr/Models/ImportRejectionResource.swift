/// The severity of an import rejection.
public enum RejectionType: String, Equatable, Codable, Sendable {
	/// The rejection cannot be overridden; the import cannot proceed as-is.
	case permanent
	/// The rejection may clear on its own, e.g. once more information becomes available.
	case temporary
}

/// A reason a manual import candidate was rejected.
public struct ImportRejectionResource: Equatable, Codable, Sendable {
	/// A human-readable explanation of the rejection.
	public let reason: String?
	/// The severity of the rejection.
	public let type: RejectionType?

	/// Creates an import rejection.
	/// - Parameters:
	///   - reason: A human-readable explanation of the rejection.
	///   - type: The severity of the rejection.
	public init(reason: String? = nil, type: RejectionType? = nil) {
		self.reason = reason
		self.type = type
	}
}
