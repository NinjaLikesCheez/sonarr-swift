import Foundation

/// Information about the running Sonarr instance and its environment.
public struct SystemResource: Equatable, Decodable, Sendable {
	/// The application name, e.g. `Sonarr`.
	public let appName: String?
	/// The user-configured name for this instance.
	public let instanceName: String?
	/// The running Sonarr version.
	public let version: String?
	/// When the running build was produced.
	public let buildTime: Date?
	/// Whether this is a debug build.
	public let isDebug: Bool?
	/// Whether this is a production build.
	public let isProduction: Bool?
	/// Whether Sonarr is running with administrator/root privileges.
	public let isAdmin: Bool?
	/// Whether Sonarr is running interactively, e.g. attached to a terminal.
	public let isUserInteractive: Bool?
	/// The path Sonarr was launched from.
	public let startupPath: String?
	/// The path Sonarr stores its application data in.
	public let appData: String?
	/// The name of the host operating system.
	public let osName: String?
	/// The version of the host operating system.
	public let osVersion: String?
	/// Whether Sonarr is running on .NET (Core), as opposed to .NET Framework.
	public let isNetCore: Bool?
	/// Whether the host operating system is Linux.
	public let isLinux: Bool?
	/// Whether the host operating system is macOS.
	public let isOsx: Bool?
	/// Whether the host operating system is Windows.
	public let isWindows: Bool?
	/// Whether Sonarr is running inside a Docker container.
	public let isDocker: Bool?
	/// The mode Sonarr's process is running under.
	public let mode: RuntimeMode?
	/// The branch Sonarr checks for updates on.
	public let branch: String?
	/// The authentication method used to secure Sonarr's web UI and API.
	public let authentication: AuthenticationType?
	/// The version of SQLite in use, if applicable.
	public let sqliteVersion: String?
	/// The database schema migration Sonarr is currently at.
	public let migrationVersion: Int?
	/// The base URL path Sonarr is served under, if configured.
	public let urlBase: String?
	/// The version of the .NET runtime in use.
	public let runtimeVersion: String?
	/// The name of the .NET runtime in use.
	public let runtimeName: String?
	/// When Sonarr started.
	public let startTime: Date?
	/// The version of the OS package Sonarr was installed from, if applicable.
	public let packageVersion: String?
	/// The author of the OS package Sonarr was installed from, if applicable.
	public let packageAuthor: String?
	/// How Sonarr applies updates to itself.
	public let packageUpdateMechanism: UpdateMechanism?
	/// Additional detail about the update mechanism, if any.
	public let packageUpdateMechanismMessage: String?
	/// The version of the connected database.
	public let databaseVersion: String?
	/// The database engine backing Sonarr's data store.
	public let databaseType: DatabaseType?
}
