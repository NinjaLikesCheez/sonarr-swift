import Foundation

/// A database/config backup available on the Sonarr server.
public struct BackupResource: Equatable, Decodable, Sendable {
	/// The backup's unique identifier.
	public let id: Int
	/// The backup's file name.
	public let name: String
	/// The path to the backup file, relative to the server.
	public let path: String
	/// How the backup was created.
	public let type: BackupType
	/// The size of the backup file, in bytes.
	public let size: Int
	/// When the backup was created.
	public let time: Date
}

/// How a `BackupResource` was created.
public enum BackupType: String, Equatable, Decodable, Sendable {
	/// Created automatically on Sonarr's backup schedule.
	case scheduled
	/// Triggered manually by a user.
	case manual
	/// Created automatically before an application update.
	case update
}

/// The result of restoring a Sonarr backup.
public struct BackupRestoreResult: Equatable, Decodable, Sendable {
	/// Whether Sonarr must be restarted to complete the restore.
	public let restartRequired: Bool
}
