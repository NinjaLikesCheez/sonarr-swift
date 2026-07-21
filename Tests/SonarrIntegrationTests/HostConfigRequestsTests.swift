import Sonarr
import Testing

@Suite("HostConfig Requests", .serialized)
struct HostConfigRequestsTests {
	@Test
	func test_hostConfig_hostConfigById_updateHostConfig() async throws {
		let config = try await client.request(.hostConfig)
		let id = try #require(config.id)

		let fetched = try await client.request(.hostConfig(id: id))
		#expect(fetched.id == id)

		let toggled = HostConfigResource(
			id: id,
			bindAddress: config.bindAddress,
			port: config.port,
			sslPort: config.sslPort,
			enableSsl: config.enableSsl,
			launchBrowser: !config.launchBrowser,
			authenticationMethod: config.authenticationMethod,
			authenticationRequired: config.authenticationRequired,
			analyticsEnabled: config.analyticsEnabled,
			username: config.username,
			password: config.password,
			passwordConfirmation: config.passwordConfirmation,
			logLevel: config.logLevel,
			logSizeLimit: config.logSizeLimit,
			consoleLogLevel: config.consoleLogLevel,
			branch: config.branch,
			apiKey: config.apiKey,
			sslCertPath: config.sslCertPath,
			sslCertPassword: config.sslCertPassword,
			urlBase: config.urlBase,
			instanceName: config.instanceName,
			applicationUrl: config.applicationUrl,
			updateAutomatically: config.updateAutomatically,
			updateMechanism: config.updateMechanism,
			updateScriptPath: config.updateScriptPath,
			proxyEnabled: config.proxyEnabled,
			proxyType: config.proxyType,
			proxyHostname: config.proxyHostname,
			proxyPort: config.proxyPort,
			proxyUsername: config.proxyUsername,
			proxyPassword: config.proxyPassword,
			proxyBypassFilter: config.proxyBypassFilter,
			proxyBypassLocalAddresses: config.proxyBypassLocalAddresses,
			certificateValidation: config.certificateValidation,
			backupFolder: config.backupFolder,
			backupInterval: config.backupInterval,
			backupRetention: config.backupRetention,
			trustCgnatIpAddresses: config.trustCgnatIpAddresses
		)

		let updated = try await client.request(.updateHostConfig(id: id, toggled))
		#expect(updated.launchBrowser == !config.launchBrowser)

		// Restore the original value so this test doesn't leave the server's config mutated for other runs.
		_ = try await client.request(.updateHostConfig(id: id, config))
	}
}
