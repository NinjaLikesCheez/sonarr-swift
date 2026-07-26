/// The database engine backing Sonarr's data store.
public enum DatabaseType: String, Equatable, Codable, Sendable {
	/// Sonarr is using an embedded SQLite database.
	case sqLite
	/// Sonarr is using an external PostgreSQL database.
	case postgreSQL
}
