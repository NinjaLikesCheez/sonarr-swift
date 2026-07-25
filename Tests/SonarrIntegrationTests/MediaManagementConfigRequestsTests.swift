import Sonarr
import Testing

@Suite("MediaManagementConfig Requests", .serialized)
struct MediaManagementConfigRequestsTests {
	@Test
	func test_mediaManagementConfig_mediaManagementConfigById_updateMediaManagementConfig() async throws {
		let config = try await client.request(.mediaManagementConfig)
		let id = try #require(config.id)

		let fetched = try await client.request(.mediaManagementConfig(id: id))
		#expect(fetched.id == id)

		let toggled = MediaManagementConfigResource(
			id: id,
			autoUnmonitorPreviouslyDownloadedEpisodes: config.autoUnmonitorPreviouslyDownloadedEpisodes,
			recycleBin: config.recycleBin,
			recycleBinCleanupDays: config.recycleBinCleanupDays,
			downloadPropersAndRepacks: config.downloadPropersAndRepacks,
			createEmptySeriesFolders: !(config.createEmptySeriesFolders ?? false),
			deleteEmptyFolders: config.deleteEmptyFolders,
			fileDate: config.fileDate,
			rescanAfterRefresh: config.rescanAfterRefresh,
			setPermissionsLinux: config.setPermissionsLinux,
			chmodFolder: config.chmodFolder,
			chownGroup: config.chownGroup,
			episodeTitleRequired: config.episodeTitleRequired,
			skipFreeSpaceCheckWhenImporting: config.skipFreeSpaceCheckWhenImporting,
			minimumFreeSpaceWhenImporting: config.minimumFreeSpaceWhenImporting,
			copyUsingHardlinks: config.copyUsingHardlinks,
			useScriptImport: config.useScriptImport,
			scriptImportPath: config.scriptImportPath,
			importExtraFiles: config.importExtraFiles,
			extraFileExtensions: config.extraFileExtensions,
			enableMediaInfo: config.enableMediaInfo
		)

		let updated = try await client.request(.updateMediaManagementConfig(id: id, toggled))
		#expect(updated.createEmptySeriesFolders == toggled.createEmptySeriesFolders)

		// Restore the original value so this test doesn't leave the server's config mutated for other runs.
		_ = try await client.request(.updateMediaManagementConfig(id: id, config))
	}
}
