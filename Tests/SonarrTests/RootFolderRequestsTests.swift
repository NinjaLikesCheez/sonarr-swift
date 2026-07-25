import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("RootFolder requests")
struct RootFolderRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleRootFolder: RootFolderResource {
		RootFolderResource(id: 1, path: "/media", accessible: true, freeSpace: 123_456_789, unmappedFolders: [])
	}

	@Test func rootFoldersRequestConstruction() {
		let request = SonarrRequest.rootFolders

		#expect(request.method == .get)
		#expect(request.path == "api/v3/rootfolder")
	}

	@Test func rootFolderRequestConstruction() {
		let request = SonarrRequest.rootFolder(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/rootfolder/1")
	}

	@Test func addRootFolderRequestConstruction() throws {
		let request = SonarrRequest.addRootFolder(sampleRootFolder)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/rootfolder")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(RootFolderResource.self, from: try body.encode())
		#expect(decoded == sampleRootFolder)
	}

	@Test func deleteRootFolderRequestConstruction() {
		let request = SonarrRequest.deleteRootFolder(id: 1)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/rootfolder/1")
	}

	@Test func rootFolderResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"path": "/media",
				"accessible": true,
				"freeSpace": 123456789,
				"unmappedFolders": [
					{"name": "Some Show", "path": "/media/Some Show", "relativePath": "Some Show"}
				]
			}
			"""#.utf8
		)

		let rootFolder = try client.decoder.decode(RootFolderResource.self, from: json)

		#expect(rootFolder.id == 1)
		#expect(rootFolder.path == "/media")
		#expect(rootFolder.accessible == true)
		#expect(rootFolder.freeSpace == 123_456_789)
		#expect(rootFolder.unmappedFolders?.count == 1)
		#expect(rootFolder.unmappedFolders?.first?.name == "Some Show")
	}

	@Test func rootFolderResourceDecodingWithNullableFieldsMissing() throws {
		let json = Data(
			#"""
			{
				"id": 2
			}
			"""#.utf8
		)

		let rootFolder = try client.decoder.decode(RootFolderResource.self, from: json)

		#expect(rootFolder.id == 2)
		#expect(rootFolder.path == nil)
		#expect(rootFolder.accessible == nil)
		#expect(rootFolder.freeSpace == nil)
		#expect(rootFolder.unmappedFolders == nil)
	}

	@Test func rootFolderResourceListDecoding() throws {
		let json = Data(
			#"""
			[
				{
					"id": 1,
					"path": "/media",
					"accessible": true,
					"freeSpace": 123456789,
					"unmappedFolders": []
				}
			]
			"""#.utf8
		)

		let rootFolders = try client.decoder.decode([RootFolderResource].self, from: json)

		#expect(rootFolders.count == 1)
		#expect(rootFolders.first?.path == "/media")
	}
}
