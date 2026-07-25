/// A status message Sonarr attached to a tracked download.
public struct TrackedDownloadStatusMessage: Equatable, Decodable, Sendable {
	/// The title the message is associated with, e.g. the release or file name.
	public let title: String?
	/// The individual messages reported.
	public let messages: [String]?

	/// Creates a tracked download status message.
	/// - Parameters:
	///   - title: The title the message is associated with, e.g. the release or file name.
	///   - messages: The individual messages reported.
	public init(title: String? = nil, messages: [String]? = nil) {
		self.title = title
		self.messages = messages
	}
}
