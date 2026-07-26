import Foundation
import Sonarr
import Testing

@Suite("Language and Quality decoding")
struct LanguageAndQualityDecodingTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	// Language and Quality are embedded in most other resources (series, episodes, episode files, queue
	// items, history entries), so a null `name` here would otherwise fail an entire list response's decode.
	@Test func languageDecodingWithNullName() throws {
		let json = Data(#"{"id": 1, "name": null}"#.utf8)

		let language = try client.decoder.decode(Language.self, from: json)

		#expect(language.id == 1)
		#expect(language.name == nil)
	}

	@Test func languageDecodingWithName() throws {
		let json = Data(#"{"id": 1, "name": "English"}"#.utf8)

		let language = try client.decoder.decode(Language.self, from: json)

		#expect(language.name == "English")
	}

	@Test func qualityDecodingWithNullName() throws {
		let json = Data(#"{"id": 3, "name": null, "source": "web", "resolution": 1080}"#.utf8)

		let quality = try client.decoder.decode(Quality.self, from: json)

		#expect(quality.id == 3)
		#expect(quality.name == nil)
		#expect(quality.source == "web")
		#expect(quality.resolution == 1080)
	}

	@Test func qualityDecodingWithName() throws {
		let json = Data(#"{"id": 3, "name": "WEBDL-1080p", "source": "web", "resolution": 1080}"#.utf8)

		let quality = try client.decoder.decode(Quality.self, from: json)

		#expect(quality.name == "WEBDL-1080p")
	}
}
