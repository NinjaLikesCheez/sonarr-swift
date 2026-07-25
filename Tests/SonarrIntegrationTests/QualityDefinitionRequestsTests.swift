import Sonarr
import Testing

@Suite("QualityDefinition Requests", .serialized)
struct QualityDefinitionRequestsTests {
	@Test
	func test_qualityDefinitions_qualityDefinitionById_updateQualityDefinition() async throws {
		let definitions = try await client.request(.qualityDefinitions)
		let definition = try #require(definitions.first)
		let id = try #require(definition.id)

		let fetched = try await client.request(.qualityDefinition(id: id))
		#expect(fetched.id == id)

		let toggled = QualityDefinitionResource(
			id: id,
			quality: definition.quality,
			title: definition.title,
			weight: definition.weight,
			minSize: definition.minSize,
			maxSize: (definition.maxSize ?? 100) + 1,
			preferredSize: definition.preferredSize
		)

		let updated = try await client.request(.updateQualityDefinition(id: id, toggled))
		#expect(updated.maxSize == toggled.maxSize)

		// Restore the original value so this test doesn't leave the server's config mutated for other runs.
		_ = try await client.request(.updateQualityDefinition(id: id, definition))
	}

	@Test
	func test_updateQualityDefinitions() async throws {
		let definitions = try await client.request(.qualityDefinitions)

		let updated = try await client.request(.updateQualityDefinitions(definitions))
		#expect(updated.count == definitions.count)
	}

	@Test
	func test_qualityDefinitionLimits() async throws {
		let limits = try await client.request(.qualityDefinitionLimits)

		#expect(limits.max != nil)
	}
}
