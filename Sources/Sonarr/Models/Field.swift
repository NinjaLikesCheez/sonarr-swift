/// A single configurable field within a dynamic schema (e.g. an auto-tagging specification's options).
public struct Field: Equatable, Codable, Sendable {
	/// The display order of this field relative to others.
	public let order: Int
	/// The wire name of this field, used as the key when submitting values.
	public let name: String?
	/// The human-readable label shown for this field.
	public let label: String?
	/// The unit shown alongside this field's value, e.g. `minutes`.
	public let unit: String?
	/// Explanatory text shown alongside this field.
	public let helpText: String?
	/// A warning shown alongside this field.
	public let helpTextWarning: String?
	/// A link to further documentation for this field.
	public let helpLink: String?
	/// The current value of this field.
	public let value: AnyCodableValue?
	/// The kind of input this field renders as, e.g. `textbox`, `select`, `number`.
	public let type: String?
	/// Whether this field is only shown under the "Advanced" settings toggle.
	public let advanced: Bool
	/// The choices available when `type` is a select/dropdown.
	public let selectOptions: [SelectOption]?
	/// The action used to fetch `selectOptions` dynamically, if applicable.
	public let selectOptionsProviderAction: String?
	/// The section of the form this field is grouped under.
	public let section: String?
	/// Whether this field is hidden, e.g. `"true"`, `"false"`, or `"hiddenIfSet"`.
	public let hidden: String?
	/// How sensitive this field's value is.
	public let privacy: PrivacyLevel
	/// Placeholder text shown when this field has no value.
	public let placeholder: String?
	/// Whether this field's value is a floating-point number rather than an integer.
	public let isFloat: Bool
}
