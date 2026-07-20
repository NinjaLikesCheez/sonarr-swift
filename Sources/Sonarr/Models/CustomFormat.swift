/// A custom format Sonarr matched against a release.
public struct CustomFormat: Equatable, Decodable, Sendable {
	/// Sonarr's internal identifier for the custom format.
	public let id: Int
	/// The display name of the custom format.
	public let name: String

	/// Creates a custom format value.
	/// - Parameters:
	///   - id: Sonarr's internal identifier for the custom format.
	///   - name: The display name of the custom format.
	public init(id: Int, name: String) {
		self.id = id
		self.name = name
	}
}
