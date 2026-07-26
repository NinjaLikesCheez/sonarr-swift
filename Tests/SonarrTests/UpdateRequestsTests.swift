import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("Update requests")
struct UpdateRequestsTests {
	let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	@Test func updatesRequestConstruction() {
		let request = SonarrRequest.updates

		#expect(request.method == .get)
		#expect(request.path == "api/v3/update")
	}

	@Test func updateResourceDecoding() throws {
		let json = Data(
			#"""
			[
				{
					"id": 1,
					"version": "4.0.1.933",
					"branch": "main",
					"releaseDate": "2024-01-01T12:00:00Z",
					"fileName": "Sonarr.main.4.0.1.933.linux-core-x64.tar.gz",
					"url": "https://services.sonarr.tv/v1/update/main/updatefile",
					"installed": true,
					"installedOn": "2024-01-02T12:00:00Z",
					"installable": false,
					"latest": true,
					"changes": {
						"new": ["Added a thing"],
						"fixed": ["Fixed a bug"]
					},
					"hash": "abc123"
				}
			]
			"""#.utf8
		)

		let updates = try client.decoder.decode([UpdateResource].self, from: json)

		#expect(updates.count == 1)

		let update = try #require(updates.first)
		#expect(update.id == 1)
		#expect(update.version == "4.0.1.933")
		#expect(update.branch == "main")
		#expect(update.fileName == "Sonarr.main.4.0.1.933.linux-core-x64.tar.gz")
		#expect(update.installed == true)
		#expect(update.installable == false)
		#expect(update.latest == true)
		#expect(update.changes?.new == ["Added a thing"])
		#expect(update.changes?.fixed == ["Fixed a bug"])
		#expect(update.hash == "abc123")
	}

	@Test func updateResourceDecodingWithNullableFieldsMissing() throws {
		let json = Data(#"{"id": 2}"#.utf8)

		let update = try client.decoder.decode(UpdateResource.self, from: json)

		#expect(update.id == 2)
		#expect(update.version == nil)
		#expect(update.branch == nil)
		#expect(update.releaseDate == nil)
		#expect(update.installedOn == nil)
		#expect(update.changes == nil)
	}
}
