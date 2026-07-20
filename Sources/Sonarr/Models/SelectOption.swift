/// A single choice presented for a `Field` whose `type` is a select/dropdown.
public struct SelectOption: Equatable, Codable, Sendable {
	/// The value sent to the server when this option is selected.
	public let value: Int
	/// The human-readable label shown for this option.
	public let name: String?
	/// The display order of this option relative to others.
	public let order: Int
	/// Additional explanatory text shown alongside this option.
	public let hint: String?
}
