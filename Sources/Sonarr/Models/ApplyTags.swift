/// How the `tags` in a bulk update request are combined with a provider's existing tags.
public enum ApplyTags: String, Equatable, Codable, Sendable {
	case add
	case remove
	case replace
}
