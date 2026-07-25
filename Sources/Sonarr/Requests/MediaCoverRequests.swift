import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public extension SonarrRequest where SonarrResponse == Data {
	/// Gets a series' media cover image (poster, banner, or fanart).
	///
	/// Endpoint: `GET /api/v3/mediacover/{seriesId}/{filename}`
	///
	/// Result: the raw image bytes.
	///
	/// - Parameters:
	///   - seriesId: The unique identifier of the series the image belongs to.
	///   - filename: The image's filename, e.g. `poster.jpg`.
	static func mediaCover(seriesId: Int, filename: String) -> SonarrRequest<Data> {
		SonarrRequest(
			method: .get,
			path: "api/v3/mediacover/\(seriesId)/\(filename)",
			transform: { data, _ in data }
		)
	}
}
