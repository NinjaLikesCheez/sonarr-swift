import APIClient
import Foundation

public extension SonarrRequest where SonarrResponse == [BackupResource] {
	/// Gets the list of backups stored on the server.
	///
	/// Endpoint: `GET /api/v3/system/backup`
	///
	/// Result: the available backups, most recent first.
	static var backups: SonarrRequest<[BackupResource]> {
		SonarrRequest(method: .get, path: "api/v3/system/backup")
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Deletes a backup from the server.
	///
	/// Endpoint: `DELETE /api/v3/system/backup/{id}`
	///
	/// - Parameter id: The identifier of the backup to delete.
	static func deleteBackup(id: Int) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .delete, path: "api/v3/system/backup/\(id)")
	}
}

public extension SonarrRequest where SonarrResponse == BackupRestoreResult {
	/// Restores the server from an existing backup.
	///
	/// Endpoint: `POST /api/v3/system/backup/restore/{id}`
	///
	/// Result: whether Sonarr must be restarted to complete the restore.
	///
	/// - Parameter id: The identifier of the backup to restore.
	static func restoreBackup(id: Int) -> SonarrRequest<BackupRestoreResult> {
		SonarrRequest(method: .post, path: "api/v3/system/backup/restore/\(id)")
	}

	/// Uploads a backup archive and restores the server from it.
	///
	/// Endpoint: `POST /api/v3/system/backup/restore/upload`
	///
	/// Result: whether Sonarr must be restarted to complete the restore.
	///
	/// - Parameters:
	///   - filename: The name of the backup archive being uploaded, e.g. `sonarr_backup.zip`.
	///   - data: The contents of the backup archive.
	static func restoreBackup(filename: String, data: Data) -> SonarrRequest<BackupRestoreResult> {
		SonarrRequest(method: .post, path: "api/v3/system/backup/restore/upload") {
			MultipartFormBody([
				.filename(key: "file", filename: filename, value: data, contentType: "application/octet-stream")
			])
		}
	}
}
