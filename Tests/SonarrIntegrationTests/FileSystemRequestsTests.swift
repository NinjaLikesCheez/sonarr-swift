import Sonarr
import Testing

@Suite("FileSystem Requests", .serialized)
struct FileSystemRequestsTests {
	@Test
	func test_fileSystem_root() async throws {
		let result = try await client.request(.fileSystem(path: "/"))
		#expect(result.directories?.isEmpty == false)
	}

	@Test
	func test_fileSystem_includingFiles() async throws {
		// Trailing slash required - without one the server lists /config's parent instead.
		let result = try await client.request(.fileSystem(path: "/config/", includeFiles: true))
		#expect(result.files?.contains { $0.name == "config.xml" } == true)
	}

	@Test
	func test_fileSystem_excludingFiles() async throws {
		let result = try await client.request(.fileSystem(path: "/config/", includeFiles: false))
		#expect(result.files?.isEmpty != false)
	}

	@Test
	func test_fileSystemEntityType_file() async throws {
		let result = try await client.request(.fileSystemEntityType(path: "/config/config.xml"))
		#expect(result.type == .file)
	}

	@Test
	func test_fileSystemEntityType_folder() async throws {
		let result = try await client.request(.fileSystemEntityType(path: "/config"))
		#expect(result.type == .folder)
	}

	@Test
	func test_fileSystemEntityType_unknownPathReturnsFolder() async throws {
		// The server intentionally reports unknown paths as folders rather than leaking their absence.
		let result = try await client.request(.fileSystemEntityType(path: "/config/does-not-exist.unknown"))
		#expect(result.type == .folder)
	}

	@Test
	func test_fileSystemMediaFiles_nonexistentFolder() async throws {
		let result = try await client.request(.fileSystemMediaFiles(path: "/config/does-not-exist"))
		#expect(result.isEmpty)
	}
}
