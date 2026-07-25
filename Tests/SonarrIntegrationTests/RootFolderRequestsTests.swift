import Sonarr
import Testing

@Suite("RootFolder Requests", .serialized)
struct RootFolderRequestsTests {
	@Test
	func test_addRootFolder_rootFolders_rootFolder_deleteRootFolder() async throws {
		let created = try await client.request(.addRootFolder(RootFolderResource(path: "/media")))

		let id = try #require(created.id)
		#expect(created.path == "/media")

		let rootFolders = try await client.request(.rootFolders)
		#expect(rootFolders.contains(where: { $0.id == id }))

		let fetched = try await client.request(.rootFolder(id: id))
		#expect(fetched.id == id)

		try await client.request(.deleteRootFolder(id: id))

		let remaining = try await client.request(.rootFolders)
		#expect(!remaining.contains(where: { $0.id == id }))
	}
}
