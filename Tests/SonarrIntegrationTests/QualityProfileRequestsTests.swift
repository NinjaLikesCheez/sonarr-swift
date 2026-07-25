import Sonarr
import Testing

@Suite("QualityProfile Requests", .serialized)
struct QualityProfileRequestsTests {
	@Test
	func test_qualityProfileSchema() async throws {
		let schema = try await client.request(.qualityProfileSchema)

		#expect(schema.name != nil)
		#expect(schema.items?.isEmpty == false)
	}

	@Test
	func test_addQualityProfile_qualityProfiles_qualityProfile_updateQualityProfile_deleteQualityProfile()
		async throws
	{
		// Base the new profile on an existing one's items/cutoff instead of guessing at a valid quality tree.
		let existingProfiles = try await client.request(.qualityProfiles)
		let base = try #require(existingProfiles.first)

		let created = try await client.request(
			.addQualityProfile(
				QualityProfileResource(
					name: "Integration Test Profile",
					upgradeAllowed: base.upgradeAllowed,
					cutoff: base.cutoff,
					items: base.items,
					minFormatScore: base.minFormatScore,
					cutoffFormatScore: base.cutoffFormatScore,
					minUpgradeFormatScore: base.minUpgradeFormatScore,
					formatItems: base.formatItems
				)
			)
		)

		let id = try #require(created.id)
		#expect(created.name == "Integration Test Profile")

		let qualityProfiles = try await client.request(.qualityProfiles)
		#expect(qualityProfiles.contains(where: { $0.id == id }))

		let fetched = try await client.request(.qualityProfile(id: id))
		#expect(fetched.id == id)

		let updated = try await client.request(
			.updateQualityProfile(
				id: id,
				QualityProfileResource(
					id: id,
					name: "Integration Test Profile Renamed",
					upgradeAllowed: created.upgradeAllowed,
					cutoff: created.cutoff,
					items: created.items,
					minFormatScore: created.minFormatScore,
					cutoffFormatScore: created.cutoffFormatScore,
					minUpgradeFormatScore: created.minUpgradeFormatScore,
					formatItems: created.formatItems
				)
			)
		)
		#expect(updated.name == "Integration Test Profile Renamed")

		try await client.request(.deleteQualityProfile(id: id))

		let remaining = try await client.request(.qualityProfiles)
		#expect(!remaining.contains(where: { $0.id == id }))
	}
}
