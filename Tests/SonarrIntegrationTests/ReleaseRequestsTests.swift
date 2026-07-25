import Sonarr
import Testing

@Suite("Release Requests", .serialized)
struct ReleaseRequestsTests {
	@Test
	func test_releases() async throws {
		try await client.request(.releases())
	}

	@Test
	func test_pushRelease_invalid() async throws {
		// A fabricated release with no real download URL/indexer can't be evaluated successfully;
		// this only verifies the request reaches the server and is rejected, not a successful push.
		await #expect(throws: (Sonarr.Error).self) {
			try await client.request(
				.pushRelease(
					ReleaseResource(
						guid: "integration-test-guid",
						title: "Integration.Test.Release",
						protocol: .usenet
					)
				)
			)
		}
	}
}
