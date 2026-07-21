/// The kind of entity a filesystem listing entry represents.
public enum FileSystemEntityType: String, Equatable, Decodable, Sendable {
	case parent
	case drive
	case folder
	case file
}
