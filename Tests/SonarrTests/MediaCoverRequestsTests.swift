import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("MediaCover requests")
struct MediaCoverRequestsTests {
	@Test func mediaCoverRequestConstruction() {
		let request = SonarrRequest.mediaCover(seriesId: 1, filename: "poster.jpg")

		#expect(request.method == .get)
		#expect(request.path == "api/v3/mediacover/1/poster.jpg")
	}

	@Test func mediaCoverTransformReturnsRawData() throws {
		let request = SonarrRequest.mediaCover(seriesId: 1, filename: "poster.jpg")
		let transform = try #require(request.transform)

		let response = HTTPURLResponse(
			url: URL(string: "http://localhost:8989/api/v3/mediacover/1/poster.jpg")!,
			statusCode: 200,
			httpVersion: nil,
			headerFields: nil
		)!

		let imageBytes = Data([0xFF, 0xD8, 0xFF, 0xE0])
		let decoded = try transform(imageBytes, response)

		#expect(decoded == imageBytes)
	}
}
