import Foundation
import Sonarr
import Testing

@Suite("EpisodeFile Requests", .serialized)
struct EpisodeFileRequestsTests {
	@Test
	func test_episodeFiles_requiresSeriesIdOrEpisodeFileIds() async throws {
		// Sonarr rejects unfiltered requests - there's no Series tag support yet to seed a real series to
		// filter by, so this only exercises the validation path.
		await #expect(throws: (Sonarr.Error).self) {
			try await client.request(.episodeFiles())
		}
	}

	@Test
	func test_episodeFile_notFound() async throws {
		await #expect(throws: (Sonarr.Error).self) {
			try await client.request(.episodeFile(id: Int.max))
		}
	}

	@Test
	func test_updateEpisodeFile_notFound() async throws {
		await #expect(throws: (Sonarr.Error).self) {
			try await client.request(
				.updateEpisodeFile(
					id: Int.max,
					EpisodeFileResource(
						id: Int.max,
						seriesId: 1,
						seasonNumber: 1,
						size: 0,
						dateAdded: Date(),
						quality: QualityModel(
							quality: Quality(id: 3, name: "WEBDL-1080p", source: "web", resolution: 1080),
							revision: QualityRevision(version: 1, real: 0, isRepack: false)
						),
						customFormatScore: 0,
						releaseType: .unknown,
						qualityCutoffNotMet: false
					)
				)
			)
		}
	}

	@Test
	func test_deleteEpisodeFile_notFound() async throws {
		await #expect(throws: (Sonarr.Error).self) {
			try await client.request(.deleteEpisodeFile(id: Int.max))
		}
	}

	@Test
	func test_editEpisodeFiles_empty() async throws {
		// No episode files exist to edit yet, and Sonarr 500s on an empty identifier list ("Sequence
		// contains no elements") rather than treating it as a no-op - this exercises that behavior.
		await #expect(throws: (Sonarr.Error).self) {
			try await client.request(.editEpisodeFiles(EpisodeFileListResource(episodeFileIds: [])))
		}
	}

	@Test
	func test_deleteEpisodeFiles_empty() async throws {
		await #expect(throws: (Sonarr.Error).self) {
			try await client.request(.deleteEpisodeFiles(EpisodeFileListResource(episodeFileIds: [])))
		}
	}

	@Test
	func test_updateEpisodeFiles_empty() async throws {
		await #expect(throws: (Sonarr.Error).self) {
			try await client.request(.updateEpisodeFiles([]))
		}
	}
}
