/// The host, security, and update configuration for a Sonarr instance.
public struct HostConfigResource: Equatable, Codable, Sendable {
	/// The unique identifier of the host configuration.
	public let id: Int?
	/// The IP address Sonarr binds to.
	public let bindAddress: String?
	/// The port Sonarr's web UI and API listen on.
	public let port: Int
	/// The port Sonarr's web UI and API listen on when SSL is enabled.
	public let sslPort: Int
	/// Whether SSL is enabled.
	public let enableSsl: Bool
	/// Whether Sonarr launches a browser on startup.
	public let launchBrowser: Bool
	/// The authentication method used to secure Sonarr.
	public let authenticationMethod: AuthenticationType
	/// Controls when authentication is required.
	public let authenticationRequired: AuthenticationRequiredType
	/// Whether anonymous usage analytics are sent to the Sonarr team.
	public let analyticsEnabled: Bool
	/// The username used for authentication.
	public let username: String?
	/// The password used for authentication.
	public let password: String?
	/// The password confirmation used when changing the authentication password.
	public let passwordConfirmation: String?
	/// The minimum log level written to the log file.
	public let logLevel: String?
	/// The maximum size, in megabytes, of a log file before it is rolled over.
	public let logSizeLimit: Int
	/// The minimum log level written to the console.
	public let consoleLogLevel: String?
	/// The update branch Sonarr checks for new releases on.
	public let branch: String?
	/// The API key used to authenticate API requests.
	public let apiKey: String?
	/// The path to the SSL certificate used when SSL is enabled.
	public let sslCertPath: String?
	/// The password for the SSL certificate.
	public let sslCertPassword: String?
	/// The base URL path Sonarr is served under.
	public let urlBase: String?
	/// The display name of this Sonarr instance.
	public let instanceName: String?
	/// The externally accessible URL of this Sonarr instance.
	public let applicationUrl: String?
	/// Whether Sonarr updates itself automatically.
	public let updateAutomatically: Bool
	/// The mechanism Sonarr uses to apply updates.
	public let updateMechanism: UpdateMechanism
	/// The path to the script Sonarr runs to apply updates, when `updateMechanism` is `.script`.
	public let updateScriptPath: String?
	/// Whether outgoing requests are routed through a proxy.
	public let proxyEnabled: Bool
	/// The protocol used to connect to the proxy.
	public let proxyType: ProxyType
	/// The hostname of the proxy server.
	public let proxyHostname: String?
	/// The port of the proxy server.
	public let proxyPort: Int
	/// The username used to authenticate with the proxy.
	public let proxyUsername: String?
	/// The password used to authenticate with the proxy.
	public let proxyPassword: String?
	/// A comma-separated list of addresses that bypass the proxy.
	public let proxyBypassFilter: String?
	/// Whether local addresses bypass the proxy.
	public let proxyBypassLocalAddresses: Bool
	/// Controls how strictly Sonarr validates SSL certificates.
	public let certificateValidation: CertificateValidationType
	/// The folder backups are written to.
	public let backupFolder: String?
	/// How often, in hours, Sonarr creates an automatic backup.
	public let backupInterval: Int
	/// How many days automatic backups are retained for.
	public let backupRetention: Int
	/// Whether IP addresses in the CGNAT range are trusted as local addresses.
	public let trustCgnatIpAddresses: Bool

	/// Creates a host configuration.
	///
	/// - Parameters:
	///   - id: The unique identifier of the host configuration.
	///   - bindAddress: The IP address Sonarr binds to.
	///   - port: The port Sonarr's web UI and API listen on.
	///   - sslPort: The port Sonarr's web UI and API listen on when SSL is enabled.
	///   - enableSsl: Whether SSL is enabled.
	///   - launchBrowser: Whether Sonarr launches a browser on startup.
	///   - authenticationMethod: The authentication method used to secure Sonarr.
	///   - authenticationRequired: Controls when authentication is required.
	///   - analyticsEnabled: Whether anonymous usage analytics are sent to the Sonarr team.
	///   - username: The username used for authentication.
	///   - password: The password used for authentication.
	///   - passwordConfirmation: The password confirmation used when changing the authentication password.
	///   - logLevel: The minimum log level written to the log file.
	///   - logSizeLimit: The maximum size, in megabytes, of a log file before it is rolled over.
	///   - consoleLogLevel: The minimum log level written to the console.
	///   - branch: The update branch Sonarr checks for new releases on.
	///   - apiKey: The API key used to authenticate API requests.
	///   - sslCertPath: The path to the SSL certificate used when SSL is enabled.
	///   - sslCertPassword: The password for the SSL certificate.
	///   - urlBase: The base URL path Sonarr is served under.
	///   - instanceName: The display name of this Sonarr instance.
	///   - applicationUrl: The externally accessible URL of this Sonarr instance.
	///   - updateAutomatically: Whether Sonarr updates itself automatically.
	///   - updateMechanism: The mechanism Sonarr uses to apply updates.
	///   - updateScriptPath: The path to the script Sonarr runs to apply updates, when `updateMechanism` is `.script`.
	///   - proxyEnabled: Whether outgoing requests are routed through a proxy.
	///   - proxyType: The protocol used to connect to the proxy.
	///   - proxyHostname: The hostname of the proxy server.
	///   - proxyPort: The port of the proxy server.
	///   - proxyUsername: The username used to authenticate with the proxy.
	///   - proxyPassword: The password used to authenticate with the proxy.
	///   - proxyBypassFilter: A comma-separated list of addresses that bypass the proxy.
	///   - proxyBypassLocalAddresses: Whether local addresses bypass the proxy.
	///   - certificateValidation: Controls how strictly Sonarr validates SSL certificates.
	///   - backupFolder: The folder backups are written to.
	///   - backupInterval: How often, in hours, Sonarr creates an automatic backup.
	///   - backupRetention: How many days automatic backups are retained for.
	///   - trustCgnatIpAddresses: Whether IP addresses in the CGNAT range are trusted as local addresses.
	public init(
		id: Int? = nil,
		bindAddress: String? = nil,
		port: Int,
		sslPort: Int,
		enableSsl: Bool,
		launchBrowser: Bool,
		authenticationMethod: AuthenticationType,
		authenticationRequired: AuthenticationRequiredType,
		analyticsEnabled: Bool,
		username: String? = nil,
		password: String? = nil,
		passwordConfirmation: String? = nil,
		logLevel: String? = nil,
		logSizeLimit: Int,
		consoleLogLevel: String? = nil,
		branch: String? = nil,
		apiKey: String? = nil,
		sslCertPath: String? = nil,
		sslCertPassword: String? = nil,
		urlBase: String? = nil,
		instanceName: String? = nil,
		applicationUrl: String? = nil,
		updateAutomatically: Bool,
		updateMechanism: UpdateMechanism,
		updateScriptPath: String? = nil,
		proxyEnabled: Bool,
		proxyType: ProxyType,
		proxyHostname: String? = nil,
		proxyPort: Int,
		proxyUsername: String? = nil,
		proxyPassword: String? = nil,
		proxyBypassFilter: String? = nil,
		proxyBypassLocalAddresses: Bool,
		certificateValidation: CertificateValidationType,
		backupFolder: String? = nil,
		backupInterval: Int,
		backupRetention: Int,
		trustCgnatIpAddresses: Bool
	) {
		self.id = id
		self.bindAddress = bindAddress
		self.port = port
		self.sslPort = sslPort
		self.enableSsl = enableSsl
		self.launchBrowser = launchBrowser
		self.authenticationMethod = authenticationMethod
		self.authenticationRequired = authenticationRequired
		self.analyticsEnabled = analyticsEnabled
		self.username = username
		self.password = password
		self.passwordConfirmation = passwordConfirmation
		self.logLevel = logLevel
		self.logSizeLimit = logSizeLimit
		self.consoleLogLevel = consoleLogLevel
		self.branch = branch
		self.apiKey = apiKey
		self.sslCertPath = sslCertPath
		self.sslCertPassword = sslCertPassword
		self.urlBase = urlBase
		self.instanceName = instanceName
		self.applicationUrl = applicationUrl
		self.updateAutomatically = updateAutomatically
		self.updateMechanism = updateMechanism
		self.updateScriptPath = updateScriptPath
		self.proxyEnabled = proxyEnabled
		self.proxyType = proxyType
		self.proxyHostname = proxyHostname
		self.proxyPort = proxyPort
		self.proxyUsername = proxyUsername
		self.proxyPassword = proxyPassword
		self.proxyBypassFilter = proxyBypassFilter
		self.proxyBypassLocalAddresses = proxyBypassLocalAddresses
		self.certificateValidation = certificateValidation
		self.backupFolder = backupFolder
		self.backupInterval = backupInterval
		self.backupRetention = backupRetention
		self.trustCgnatIpAddresses = trustCgnatIpAddresses
	}
}
