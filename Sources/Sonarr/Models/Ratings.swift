/// An aggregate rating from a series' metadata source.
public struct Ratings: Equatable, Codable, Sendable {
	/// The number of votes the rating is based on.
	public let votes: Int?
	/// The rating value.
	public let value: Double?

	/// Creates a ratings value.
	/// - Parameters:
	///   - votes: The number of votes the rating is based on.
	///   - value: The rating value.
	public init(votes: Int? = nil, value: Double? = nil) {
		self.votes = votes
		self.value = value
	}
}
