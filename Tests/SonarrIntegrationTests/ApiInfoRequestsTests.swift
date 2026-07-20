import Sonarr
import Testing

@Suite("ApiInfo Requests", .serialized)
struct ApiInfoRequestsTests {
	@Test
	func test_apiInfo() async throws {
		let apiInfo = try await client.request(.apiInfo)
		#expect(apiInfo.current == "v3")
	}
}
