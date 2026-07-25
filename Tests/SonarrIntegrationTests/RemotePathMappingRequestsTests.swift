import Sonarr
import Testing

@Suite("RemotePathMapping Requests", .serialized)
struct RemotePathMappingRequestsTests {
	@Test
	func test_addRemotePathMapping_remotePathMappings_remotePathMapping_updateRemotePathMapping_deleteRemotePathMapping()
		async throws
	{
		// Sonarr validates that `localPath` exists on the server's filesystem, so this must be a
		// real path inside the test container rather than an arbitrary string.
		let created = try await client.request(
			.addRemotePathMapping(
				RemotePathMappingResource(
					host: "integration-test-host",
					remotePath: "/remote/downloads/",
					localPath: "/config"
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
					host: "integration-test-host-renamed",
					remotePath: created.remotePath,
					localPath: "/config"
				)
			)
		)
		#expect(updated.host == "integration-test-host-renamed")

		try await client.request(.deleteRemotePathMapping(id: id))

		let remaining = try await client.request(.remotePathMappings)
		#expect(!remaining.contains(where: { $0.id == id }))
	}
}
