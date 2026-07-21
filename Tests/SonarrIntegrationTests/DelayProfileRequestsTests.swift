import Foundation
import Sonarr
import Testing

@Suite("DelayProfile Requests", .serialized)
struct DelayProfileRequestsTests {
	@Test
	func test_addDelayProfile_delayProfiles_delayProfile_updateDelayProfile_deleteDelayProfile() async throws {
		let created = try await client.request(
			.addDelayProfile(
				DelayProfileResource(
					enableUsenet: true,
					enableTorrent: true,
					preferredProtocol: .usenet,
					usenetDelay: 0,
					torrentDelay: 0,
					bypassIfHighestQuality: false,
					bypassIfAboveCustomFormatScore: false,
					minimumCustomFormatScore: 0,
					tags: []
				)
			)
		)

		let id = try #require(created.id)
		#expect(created.enableUsenet == true)

		let delayProfiles = try await client.request(.delayProfiles)
		#expect(delayProfiles.contains(where: { $0.id == id }))

		let fetched = try await client.request(.delayProfile(id: id))
		#expect(fetched.id == id)

		let updated = try await client.request(
			.updateDelayProfile(
				id: id,
				DelayProfileResource(
					id: id,
					enableUsenet: false,
					enableTorrent: true,
					preferredProtocol: .torrent,
					usenetDelay: 0,
					torrentDelay: 5,
					bypassIfHighestQuality: false,
					bypassIfAboveCustomFormatScore: false,
					minimumCustomFormatScore: 0,
					tags: []
				)
			)
		)
		#expect(updated.enableUsenet == false)
		#expect(updated.torrentDelay == 5)

		try await client.request(.deleteDelayProfile(id: id))

		let remaining = try await client.request(.delayProfiles)
		#expect(!remaining.contains(where: { $0.id == id }))
	}

	@Test
	func test_reorderDelayProfile() async throws {
		let first = try await client.request(
			.addDelayProfile(
				DelayProfileResource(
					enableUsenet: true,
					enableTorrent: true,
					preferredProtocol: .usenet,
					usenetDelay: 0,
					torrentDelay: 0,
					tags: []
				)
			)
		)
		let second = try await client.request(
			.addDelayProfile(
				DelayProfileResource(
					enableUsenet: true,
					enableTorrent: true,
					preferredProtocol: .usenet,
					usenetDelay: 0,
					torrentDelay: 0,
					tags: []
				)
			)
		)

		let firstID = try #require(first.id)
		let secondID = try #require(second.id)

		let reordered = try await client.request(.reorderDelayProfile(id: firstID, after: secondID))
		#expect(reordered.contains(where: { $0.id == firstID }))

		try await client.request(.deleteDelayProfile(id: firstID))
		try await client.request(.deleteDelayProfile(id: secondID))
	}
}
