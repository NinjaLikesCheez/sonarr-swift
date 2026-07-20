import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("Backup requests")
struct BackupRequestsTests {
	let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	@Test func backupsRequestConstruction() {
		let request = SonarrRequest.backups

		#expect(request.method == .get)
		#expect(request.path == "api/v3/system/backup")
	}

	@Test func deleteBackupRequestConstruction() {
		let request = SonarrRequest.deleteBackup(id: 42)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/system/backup/42")
	}

	@Test func restoreBackupRequestConstruction() {
		let request = SonarrRequest.restoreBackup(id: 42)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/system/backup/restore/42")
	}

	@Test func restoreBackupUploadRequestConstruction() throws {
		let data = Data("backup".utf8)
		let request = SonarrRequest.restoreBackup(filename: "sonarr_backup.zip", data: data)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/system/backup/restore/upload")

		let body = try #require(try request.body())
		#expect(body.headers["Content-Type"]?.hasPrefix("multipart/form-data; boundary=") == true)

		let encoded = try body.encode()
		let encodedString = try #require(String(bytes: encoded, encoding: .utf8))
		#expect(encodedString.contains("filename=\"sonarr_backup.zip\""))
		#expect(encodedString.contains("backup"))
	}

	@Test func backupsDecoding() throws {
		let json = Data(
			#"""
			[
				{
					"id": 1,
					"name": "sonarr_backup_v3.zip",
					"path": "/backup/scheduled/sonarr_backup_v3.zip",
					"type": "scheduled",
					"size": 1024,
					"time": "2024-01-01T00:00:00Z"
				}
			]
			"""#.utf8
		)

		let backups = try client.decoder.decode([BackupResource].self, from: json)

		#expect(backups.count == 1)
		#expect(backups.first?.id == 1)
		#expect(backups.first?.name == "sonarr_backup_v3.zip")
		#expect(backups.first?.type == .scheduled)
		#expect(backups.first?.size == 1024)
	}

	@Test func backupRestoreResultDecoding() throws {
		let json = Data(#"{"restartRequired": true}"#.utf8)

		let result = try client.decoder.decode(BackupRestoreResult.self, from: json)

		#expect(result.restartRequired)
	}
}
