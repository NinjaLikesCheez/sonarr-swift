/// A tag along with the identifiers of every resource it's currently attached to.
public struct TagDetailsResource: Equatable, Decodable, Sendable {
	/// The unique identifier of this tag.
	public let id: Int?
	/// The user-facing label of this tag.
	public let label: String?
	/// The delay profiles this tag is attached to.
	public let delayProfileIds: [Int]?
	/// The import lists this tag is attached to.
	public let importListIds: [Int]?
	/// The notifications this tag is attached to.
	public let notificationIds: [Int]?
	/// The release profiles this tag is attached to.
	public let restrictionIds: [Int]?
	/// The indexers this tag is attached to.
	public let indexerIds: [Int]?
	/// The download clients this tag is attached to.
	public let downloadClientIds: [Int]?
	/// The auto-tagging rules this tag is attached to.
	public let autoTagIds: [Int]?
	/// The series this tag is attached to.
	public let seriesIds: [Int]?
}
