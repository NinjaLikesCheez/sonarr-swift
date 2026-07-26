/// The notable changes included in an update.
public struct UpdateChanges: Equatable, Decodable, Sendable {
	/// New features or capabilities added by the update.
	public let new: [String]?
	/// Bugs fixed by the update.
	public let fixed: [String]?
}
