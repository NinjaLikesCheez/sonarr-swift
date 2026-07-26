import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("System requests")
struct SystemRequestsTests {
	let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	@Test func systemStatusRequestConstruction() {
		let request = SonarrRequest.systemStatus

		#expect(request.method == .get)
		#expect(request.path == "api/v3/system/status")
	}

	@Test func systemRoutesRequestConstruction() {
		let request = SonarrRequest.systemRoutes

		#expect(request.method == .get)
		#expect(request.path == "api/v3/system/routes")
	}

	@Test func systemDuplicateRoutesRequestConstruction() {
		let request = SonarrRequest.systemDuplicateRoutes

		#expect(request.method == .get)
		#expect(request.path == "api/v3/system/routes/duplicate")
	}

	@Test func shutdownSystemRequestConstruction() {
		let request = SonarrRequest.shutdownSystem

		#expect(request.method == .post)
		#expect(request.path == "api/v3/system/shutdown")
	}

	@Test func restartSystemRequestConstruction() {
		let request = SonarrRequest.restartSystem

		#expect(request.method == .post)
		#expect(request.path == "api/v3/system/restart")
	}

	@Test func systemResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"appName": "Sonarr",
				"instanceName": "Sonarr",
				"version": "4.0.0.0",
				"buildTime": "2024-01-01T12:00:00Z",
				"isDebug": false,
				"isProduction": true,
				"isAdmin": false,
				"isUserInteractive": false,
				"startupPath": "/app",
				"appData": "/config",
				"osName": "Ubuntu",
				"osVersion": "22.04",
				"isNetCore": true,
				"isLinux": true,
				"isOsx": false,
				"isWindows": false,
				"isDocker": true,
				"mode": "console",
				"branch": "main",
				"authentication": "forms",
				"sqliteVersion": "3.45.0",
				"migrationVersion": 220,
				"urlBase": "",
				"runtimeVersion": "8.0.0",
				"runtimeName": ".NET",
				"startTime": "2024-01-01T12:00:00Z",
				"packageVersion": "4.0.0",
				"packageAuthor": "linuxserver.io",
				"packageUpdateMechanism": "docker",
				"packageUpdateMechanismMessage": null,
				"databaseVersion": "3.45.0",
				"databaseType": "sqLite"
			}
			"""#.utf8
		)

		let status = try client.decoder.decode(SystemResource.self, from: json)

		#expect(status.appName == "Sonarr")
		#expect(status.version == "4.0.0.0")
		#expect(status.isProduction == true)
		#expect(status.osName == "Ubuntu")
		#expect(status.isDocker == true)
		#expect(status.mode == .console)
		#expect(status.authentication == .forms)
		#expect(status.migrationVersion == 220)
		#expect(status.packageUpdateMechanism == .docker)
		#expect(status.databaseType == .sqLite)
	}

	@Test func systemResourceDecodingWithNullableFieldsMissing() throws {
		let json = Data(#"{}"#.utf8)

		let status = try client.decoder.decode(SystemResource.self, from: json)

		#expect(status.appName == nil)
		#expect(status.version == nil)
		#expect(status.mode == nil)
		#expect(status.authentication == nil)
		#expect(status.databaseType == nil)
	}

	@Test func systemDuplicateRoutesDecodingEmpty() throws {
		let json = Data(#"{}"#.utf8)

		let duplicates = try client.decoder.decode([String: [String]].self, from: json)

		#expect(duplicates.isEmpty)
	}

	@Test func systemDuplicateRoutesDecodingWithEntries() throws {
		let json = Data(
			#"""
			{
				"GET api/v3/series": ["Sonarr.Api.V3.Series.SeriesController.GetSeries"]
			}
			"""#.utf8
		)

		let duplicates = try client.decoder.decode([String: [String]].self, from: json)

		#expect(duplicates["GET api/v3/series"] == ["Sonarr.Api.V3.Series.SeriesController.GetSeries"])
	}

	@Test func shutdownResourceDecoding() throws {
		let json = Data(#"{"shuttingDown": true}"#.utf8)

		let resource = try client.decoder.decode(SystemShutdownResource.self, from: json)

		#expect(resource.shuttingDown == true)
	}

	@Test func restartResourceDecoding() throws {
		let json = Data(#"{"restarting": true}"#.utf8)

		let resource = try client.decoder.decode(SystemRestartResource.self, from: json)

		#expect(resource.restarting == true)
	}
}
