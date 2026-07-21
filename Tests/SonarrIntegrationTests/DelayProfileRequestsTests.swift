import APIClient
import Foundation
import Sonarr
import Testing

// Sonarr requires at least one tag on a delay profile - tags aren't covered by this issue's tag (see the
// Tag OpenAPI group), so create one directly here rather than pulling in unrelated library surface.
private struct TagResource: Codable {
	let id: Int?
	let label: String
}

private func createTag(label: String) async throws -> Int {
	let request = SonarrRequest<TagResource>(
		method: .post,
		path: "api/v3/tag",
		body: { JSONBody(TagResource(id: nil, label: label)) }
	)
	let tag = try await client.request(request)
	return try #require(tag.id)
}

private func deleteTag(id: Int) async throws {
	try await client.request(SonarrRequest<EmptyResponse>(method: .delete, path: "api/v3/tag/\(id)"))
}

@Suite("DelayProfile Requests", .serialized)
struct DelayProfileRequestsTests {
	@Test
	func test_addDelayProfile_delayProfiles_delayProfile_updateDelayProfile_deleteDelayProfile() async throws {
		let tagID = try await createTag(label: "integration-test-delayprofile")

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
					tags: [tagID]
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
					tags: [tagID]
				)
			)
		)
		#expect(updated.enableUsenet == false)
		#expect(updated.torrentDelay == 5)

		try await client.request(.deleteDelayProfile(id: id))

		let remaining = try await client.request(.delayProfiles)
		#expect(!remaining.contains(where: { $0.id == id }))

		try await deleteTag(id: tagID)
	}

	@Test
	func test_reorderDelayProfile() async throws {
		// Sonarr rejects a tag that's already used by another delay profile, so each profile needs its own tag.
		let firstTagID = try await createTag(label: "integration-test-delayprofile-reorder-1")
		let secondTagID = try await createTag(label: "integration-test-delayprofile-reorder-2")

		let first = try await client.request(
			.addDelayProfile(
				DelayProfileResource(
					enableUsenet: true,
					enableTorrent: true,
					preferredProtocol: .usenet,
					usenetDelay: 0,
					torrentDelay: 0,
					tags: [firstTagID]
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
					tags: [secondTagID]
				)
			)
		)

		let firstID = try #require(first.id)
		let secondID = try #require(second.id)

		let reordered = try await client.request(.reorderDelayProfile(id: firstID, after: secondID))
		#expect(reordered.contains(where: { $0.id == firstID }))

		try await client.request(.deleteDelayProfile(id: firstID))
		try await client.request(.deleteDelayProfile(id: secondID))

		try await deleteTag(id: firstTagID)
		try await deleteTag(id: secondTagID)
	}
}
