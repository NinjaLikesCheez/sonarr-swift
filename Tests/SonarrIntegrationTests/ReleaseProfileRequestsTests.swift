import Sonarr
import Testing

@Suite("ReleaseProfile Requests", .serialized)
struct ReleaseProfileRequestsTests {
	@Test
	func test_addReleaseProfile_releaseProfiles_releaseProfile_updateReleaseProfile_deleteReleaseProfile()
		async throws
	{
		let created = try await client.request(
			.addReleaseProfile(
				ReleaseProfileResource(
					name: "Integration Test Profile",
					enabled: true,
					required: ["1080p"],
					ignored: ["FRENCH"],
					indexerId: 0,
					tags: []
				)
			)
		)

		let id = try #require(created.id)
		#expect(created.name == "Integration Test Profile")

		let releaseProfiles = try await client.request(.releaseProfiles)
		#expect(releaseProfiles.contains(where: { $0.id == id }))

		let fetched = try await client.request(.releaseProfile(id: id))
		#expect(fetched.id == id)

		let updated = try await client.request(
			.updateReleaseProfile(
				id: id,
				ReleaseProfileResource(
					id: id,
					name: "Integration Test Profile Renamed",
					enabled: false,
					required: created.required,
					ignored: created.ignored,
					indexerId: created.indexerId,
					tags: created.tags
				)
			)
		)
		#expect(updated.name == "Integration Test Profile Renamed")
		#expect(updated.enabled == false)

		try await client.request(.deleteReleaseProfile(id: id))

		let remaining = try await client.request(.releaseProfiles)
		#expect(!remaining.contains(where: { $0.id == id }))
	}
}
