import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("FileSystem requests")
struct FileSystemRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private func queryItems<Response>(
		of request: SonarrRequest<Response>,
		path: String
	) -> [URLQueryItem]? {
		let urlRequest = URLRequest(url: URL(string: "http://localhost:8989/\(path)")!)
		let prepared = request.prepare(urlRequest)
		return URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)?.queryItems
	}

	@Test func fileSystemRequestConstruction() {
		let request = SonarrRequest.fileSystem(path: "/data")

		#expect(request.method == .get)
		#expect(request.path == "api/v3/filesystem")
		#expect(
			queryItems(of: request, path: "api/v3/filesystem") == [
				URLQueryItem(name: "includeFiles", value: "false"),
				URLQueryItem(name: "allowFoldersWithoutTrailingSlashes", value: "false"),
				URLQueryItem(name: "path", value: "/data"),
			]
		)
	}

	@Test func fileSystemRequestConstructionWithoutPath() {
		let request = SonarrRequest.fileSystem()

		#expect(queryItems(of: request, path: "api/v3/filesystem")?.contains { $0.name == "path" } == false)
	}

	@Test func fileSystemRequestConstructionWithOptions() {
		let request = SonarrRequest.fileSystem(
			path: "/data",
			includeFiles: true,
			allowFoldersWithoutTrailingSlashes: true
		)

		#expect(
			queryItems(of: request, path: "api/v3/filesystem") == [
				URLQueryItem(name: "includeFiles", value: "true"),
				URLQueryItem(name: "allowFoldersWithoutTrailingSlashes", value: "true"),
				URLQueryItem(name: "path", value: "/data"),
			]
		)
	}

	@Test func fileSystemEntityTypeRequestConstruction() {
		let request = SonarrRequest.fileSystemEntityType(path: "/data/movie.mkv")

		#expect(request.method == .get)
		#expect(request.path == "api/v3/filesystem/type")
		#expect(
			queryItems(of: request, path: "api/v3/filesystem/type") == [
				URLQueryItem(name: "path", value: "/data/movie.mkv")
			]
		)
	}

	@Test func fileSystemMediaFilesRequestConstruction() {
		let request = SonarrRequest.fileSystemMediaFiles(path: "/data")

		#expect(request.method == .get)
		#expect(request.path == "api/v3/filesystem/mediafiles")
		#expect(
			queryItems(of: request, path: "api/v3/filesystem/mediafiles") == [
				URLQueryItem(name: "path", value: "/data")
			]
		)
	}

	@Test func fileSystemResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"parent": "/",
				"directories": [
					{
						"type": "folder",
						"name": "data",
						"path": "/data/",
						"lastModified": "2024-01-15T10:30:00Z"
					}
				],
				"files": [
					{
						"type": "file",
						"name": "movie.mkv",
						"path": "/data/movie.mkv",
						"extension": ".mkv",
						"size": 1000000000,
						"lastModified": "2024-01-15T10:30:00Z"
					}
				]
			}
			"""#.utf8
		)

		let fileSystem = try client.decoder.decode(FileSystemResource.self, from: json)

		#expect(fileSystem.parent == "/")

		let directory = try #require(fileSystem.directories?.first)
		#expect(directory.type == .folder)
		#expect(directory.name == "data")
		#expect(directory.path == "/data/")
		#expect(directory.extension == nil)
		#expect(directory.size == nil)

		let file = try #require(fileSystem.files?.first)
		#expect(file.type == .file)
		#expect(file.name == "movie.mkv")
		#expect(file.extension == ".mkv")
		#expect(file.size == 1_000_000_000)
	}

	@Test func fileSystemResourceDecodingWithoutFiles() throws {
		let json = Data(
			#"""
			{
				"parent": "/",
				"directories": [],
				"files": null
			}
			"""#.utf8
		)

		let fileSystem = try client.decoder.decode(FileSystemResource.self, from: json)

		#expect(fileSystem.parent == "/")
		#expect(fileSystem.directories?.isEmpty == true)
		#expect(fileSystem.files == nil)
	}

	@Test func fileSystemEntityTypeResourceDecodingFile() throws {
		let json = Data(#"{"type": "file"}"#.utf8)

		let entityType = try client.decoder.decode(FileSystemEntityTypeResource.self, from: json)

		#expect(entityType.type == .file)
	}

	@Test func fileSystemEntityTypeResourceDecodingFolder() throws {
		let json = Data(#"{"type": "folder"}"#.utf8)

		let entityType = try client.decoder.decode(FileSystemEntityTypeResource.self, from: json)

		#expect(entityType.type == .folder)
	}

	@Test func mediaFileResourceListDecoding() throws {
		let json = Data(
			#"""
			[
				{
					"path": "/data/somevideo.mkv",
					"relativePath": "somevideo.mkv",
					"name": "somevideo.mkv"
				}
			]
			"""#.utf8
		)

		let mediaFiles = try client.decoder.decode([MediaFileResource].self, from: json)

		#expect(mediaFiles.count == 1)

		let mediaFile = try #require(mediaFiles.first)
		#expect(mediaFile.path == "/data/somevideo.mkv")
		#expect(mediaFile.relativePath == "somevideo.mkv")
		#expect(mediaFile.name == "somevideo.mkv")
	}
}
