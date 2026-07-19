public extension Sonarr {
	/// The JSON error envelope Sonarr returns alongside non-2xx status codes.
	struct ErrorResponse: Decodable, Sendable {
		/// A short summary of the error.
		public let message: String?
		/// A longer description of the error, when Sonarr provides one.
		public let description: String?
	}
}
