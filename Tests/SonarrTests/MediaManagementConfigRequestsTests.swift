import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("MediaManagementConfig requests")
struct MediaManagementConfigRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleMediaManagementConfig: MediaManagementConfigResource {
		MediaManagementConfigResource(
			id: 1,
			autoUnmonitorPreviouslyDownloadedEpisodes: false,
			recycleBin: "",
			recycleBinCleanupDays: 7,
			downloadPropersAndRepacks: .preferAndUpgrade,
			createEmptySeriesFolders: false,
			deleteEmptyFolders: false,
			fileDate: FileDateType.none,
			rescanAfterRefresh: .always,
			setPermissionsLinux: false,
			chmodFolder: "755",
			chownGroup: "",
			episodeTitleRequired: .always,
			skipFreeSpaceCheckWhenImporting: false,
			minimumFreeSpaceWhenImporting: 100,
			copyUsingHardlinks: true,
			useScriptImport: false,
			scriptImportPath: "",
			importExtraFiles: false,
			extraFileExtensions: "srt",
			enableMediaInfo: true
		)
	}

	@Test func mediaManagementConfigRequestConstruction() {
		let request = SonarrRequest.mediaManagementConfig

		#expect(request.method == .get)
		#expect(request.path == "api/v3/config/mediamanagement")
	}

	@Test func mediaManagementConfigByIdRequestConstruction() {
		let request = SonarrRequest.mediaManagementConfig(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/config/mediamanagement/1")
	}

	@Test func updateMediaManagementConfigRequestConstruction() throws {
		let request = SonarrRequest.updateMediaManagementConfig(id: 1, sampleMediaManagementConfig)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/config/mediamanagement/1")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["autoUnmonitorPreviouslyDownloadedEpisodes"] as? Bool == false)
		#expect(json["recycleBin"] as? String == "")
		#expect(json["recycleBinCleanupDays"] as? Int == 7)
		#expect(json["downloadPropersAndRepacks"] as? String == "preferAndUpgrade")
		#expect(json["createEmptySeriesFolders"] as? Bool == false)
		#expect(json["deleteEmptyFolders"] as? Bool == false)
		#expect(json["fileDate"] as? String == "none")
		#expect(json["rescanAfterRefresh"] as? String == "always")
		#expect(json["setPermissionsLinux"] as? Bool == false)
		#expect(json["chmodFolder"] as? String == "755")
		#expect(json["chownGroup"] as? String == "")
		#expect(json["episodeTitleRequired"] as? String == "always")
		#expect(json["skipFreeSpaceCheckWhenImporting"] as? Bool == false)
		#expect(json["minimumFreeSpaceWhenImporting"] as? Int == 100)
		#expect(json["copyUsingHardlinks"] as? Bool == true)
		#expect(json["useScriptImport"] as? Bool == false)
		#expect(json["scriptImportPath"] as? String == "")
		#expect(json["importExtraFiles"] as? Bool == false)
		#expect(json["extraFileExtensions"] as? String == "srt")
		#expect(json["enableMediaInfo"] as? Bool == true)
	}

	@Test func mediaManagementConfigResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"autoUnmonitorPreviouslyDownloadedEpisodes": false,
				"recycleBin": "",
				"recycleBinCleanupDays": 7,
				"downloadPropersAndRepacks": "preferAndUpgrade",
				"createEmptySeriesFolders": false,
				"deleteEmptyFolders": false,
				"fileDate": "none",
				"rescanAfterRefresh": "always",
				"setPermissionsLinux": false,
				"chmodFolder": "755",
				"chownGroup": "",
				"episodeTitleRequired": "always",
				"skipFreeSpaceCheckWhenImporting": false,
				"minimumFreeSpaceWhenImporting": 100,
				"copyUsingHardlinks": true,
				"useScriptImport": false,
				"scriptImportPath": "",
				"importExtraFiles": false,
				"extraFileExtensions": "srt",
				"enableMediaInfo": true
			}
			"""#.utf8
		)

		let config = try client.decoder.decode(MediaManagementConfigResource.self, from: json)

		#expect(config.id == 1)
		#expect(config.downloadPropersAndRepacks == .preferAndUpgrade)
		#expect(config.fileDate == FileDateType.none)
		#expect(config.rescanAfterRefresh == .always)
		#expect(config.episodeTitleRequired == .always)
		#expect(config.minimumFreeSpaceWhenImporting == 100)
		#expect(config.enableMediaInfo == true)
	}

	@Test func mediaManagementConfigResourceDecodingWithNullFields() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"recycleBin": null,
				"downloadPropersAndRepacks": null,
				"fileDate": null,
				"rescanAfterRefresh": null,
				"chmodFolder": null,
				"chownGroup": null,
				"episodeTitleRequired": null,
				"scriptImportPath": null,
				"extraFileExtensions": null
			}
			"""#.utf8
		)

		let config = try client.decoder.decode(MediaManagementConfigResource.self, from: json)

		#expect(config.recycleBin == nil)
		#expect(config.downloadPropersAndRepacks == nil)
		#expect(config.fileDate == nil)
		#expect(config.rescanAfterRefresh == nil)
		#expect(config.chmodFolder == nil)
		#expect(config.chownGroup == nil)
		#expect(config.episodeTitleRequired == nil)
		#expect(config.scriptImportPath == nil)
		#expect(config.extraFileExtensions == nil)
	}
}
