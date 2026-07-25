/// The minimum and maximum size limits allowed across all quality definitions.
public struct QualityDefinitionLimitsResource: Equatable, Decodable, Sendable {
	/// The lowest minimum size allowed, in megabytes per minute of runtime.
	public let min: Int?
	/// The highest maximum size allowed, in megabytes per minute of runtime.
	public let max: Int?
}
