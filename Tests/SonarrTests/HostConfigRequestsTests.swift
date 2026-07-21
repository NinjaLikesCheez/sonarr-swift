import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("HostConfig requests")
struct HostConfigRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleHostConfig: HostConfigResource {
		HostConfigResource(
			id: 1,
			bindAddress: "*",
			port: 8989,
			sslPort: 9898,
			enableSsl: false,
			launchBrowser: true,
			authenticationMethod: .forms,
			authenticationRequired: .enabled,
			analyticsEnabled: true,
			username: "admin",
			password: "hunter2",
			passwordConfirmation: "hunter2",
			logLevel: "info",
			logSizeLimit: 1,
			consoleLogLevel: nil,
			branch: "main",
			apiKey: "test-api-key",
			sslCertPath: nil,
			sslCertPassword: nil,
			urlBase: nil,
			instanceName: "Sonarr",
			applicationUrl: nil,
			updateAutomatically: false,
			updateMechanism: .docker,
			updateScriptPath: nil,
			proxyEnabled: false,
			proxyType: .http,
			proxyHostname: nil,
			proxyPort: 8080,
			proxyUsername: nil,
			proxyPassword: nil,
			proxyBypassFilter: nil,
			proxyBypassLocalAddresses: true,
			certificateValidation: .enabled,
			backupFolder: "Backups",
			backupInterval: 7,
			backupRetention: 28,
			trustCgnatIpAddresses: true
		)
	}

	@Test func hostConfigRequestConstruction() {
		let request = SonarrRequest.hostConfig

		#expect(request.method == .get)
		#expect(request.path == "api/v3/config/host")
	}

	@Test func hostConfigByIdRequestConstruction() {
		let request = SonarrRequest.hostConfig(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/config/host/1")
	}

	@Test func updateHostConfigRequestConstruction() throws {
		let request = SonarrRequest.updateHostConfig(id: 1, sampleHostConfig)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/config/host/1")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(HostConfigResource.self, from: try body.encode())
		#expect(decoded == sampleHostConfig)
	}

	@Test func hostConfigResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"bindAddress": "*",
				"port": 8989,
				"sslPort": 9898,
				"enableSsl": false,
				"launchBrowser": true,
				"authenticationMethod": "forms",
				"authenticationRequired": "enabled",
				"analyticsEnabled": true,
				"username": "admin",
				"password": "hunter2",
				"passwordConfirmation": "hunter2",
				"logLevel": "info",
				"logSizeLimit": 1,
				"consoleLogLevel": null,
				"branch": "main",
				"apiKey": "test-api-key",
				"sslCertPath": null,
				"sslCertPassword": null,
				"urlBase": null,
				"instanceName": "Sonarr",
				"applicationUrl": null,
				"updateAutomatically": false,
				"updateMechanism": "docker",
				"updateScriptPath": null,
				"proxyEnabled": false,
				"proxyType": "http",
				"proxyHostname": null,
				"proxyPort": 8080,
				"proxyUsername": null,
				"proxyPassword": null,
				"proxyBypassFilter": null,
				"proxyBypassLocalAddresses": true,
				"certificateValidation": "enabled",
				"backupFolder": "Backups",
				"backupInterval": 7,
				"backupRetention": 28,
				"trustCgnatIpAddresses": true
			}
			"""#.utf8
		)

		let config = try client.decoder.decode(HostConfigResource.self, from: json)

		#expect(config.id == 1)
		#expect(config.bindAddress == "*")
		#expect(config.port == 8989)
		#expect(config.sslPort == 9898)
		#expect(config.enableSsl == false)
		#expect(config.authenticationMethod == .forms)
		#expect(config.authenticationRequired == .enabled)
		#expect(config.updateMechanism == .docker)
		#expect(config.proxyType == .http)
		#expect(config.certificateValidation == .enabled)
	}

	@Test func hostConfigResourceDecodingWithNullOptionalFields() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"bindAddress": null,
				"port": 8989,
				"sslPort": 9898,
				"enableSsl": false,
				"launchBrowser": true,
				"authenticationMethod": "none",
				"authenticationRequired": "disabledForLocalAddresses",
				"analyticsEnabled": false,
				"username": null,
				"password": null,
				"passwordConfirmation": null,
				"logLevel": null,
				"logSizeLimit": 1,
				"consoleLogLevel": null,
				"branch": null,
				"apiKey": null,
				"sslCertPath": null,
				"sslCertPassword": null,
				"urlBase": null,
				"instanceName": null,
				"applicationUrl": null,
				"updateAutomatically": false,
				"updateMechanism": "builtIn",
				"updateScriptPath": null,
				"proxyEnabled": false,
				"proxyType": "socks5",
				"proxyHostname": null,
				"proxyPort": 0,
				"proxyUsername": null,
				"proxyPassword": null,
				"proxyBypassFilter": null,
				"proxyBypassLocalAddresses": false,
				"certificateValidation": "disabled",
				"backupFolder": null,
				"backupInterval": 7,
				"backupRetention": 28,
				"trustCgnatIpAddresses": false
			}
			"""#.utf8
		)

		let config = try client.decoder.decode(HostConfigResource.self, from: json)

		#expect(config.bindAddress == nil)
		#expect(config.username == nil)
		#expect(config.authenticationMethod == .none)
		#expect(config.updateMechanism == .builtIn)
		#expect(config.proxyType == .socks5)
		#expect(config.certificateValidation == .disabled)
	}
}
