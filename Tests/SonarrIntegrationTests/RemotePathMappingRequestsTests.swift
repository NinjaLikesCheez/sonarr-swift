import Sonarr
import Testing

@Suite("RemotePathMapping Requests", .serialized)
struct RemotePathMappingRequestsTests {
	@Test
	func test_addRemotePathMapping_remotePathMappings_remotePathMapping_updateRemotePathMapping_deleteRemotePathMapping()
		async throws
	{
		let created = try await client.request(
			.addRemotePathMapping(
				RemotePathMappingResource(
					host: "integration-test-host",
					remotePath: "/remote/downloads/",
					localPath: "/local/downloads/"
				)
			)
		)

		let id = try #require(created.id)
		#expect(created.host == "integration-test-host")

		let remotePathMappings = try await client.request(.remotePathMappings)
		#expect(remotePathMappings.contains(where: { $0.id == id }))

		let fetched = try await client.request(.remotePathMapping(id: id))
		#expect(fetched.id == id)

		let updated = try await client.request(
			.updateRemotePathMapping(
				id: id,
				RemotePathMappingResource(
					id: id,
					host: created.host,
					remotePath: created.remotePath,
					localPath: "/local/downloads-renamed/"
				)
			)
		)
		#expect(updated.localPath == "/local/downloads-renamed/")

		try await client.request(.deleteRemotePathMapping(id: id))

		let remaining = try await client.request(.remotePathMappings)
		#expect(!remaining.contains(where: { $0.id == id }))
	}
}
