import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("DiskSpace requests")
struct DiskSpaceRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	@Test func diskSpaceRequestConstruction() {
		let request = SonarrRequest.diskSpace

		#expect(request.method == .get)
		#expect(request.path == "api/v3/diskspace")
	}

	@Test func diskSpaceResourceListDecoding() throws {
		let json = Data(
			#"""
			[
				{
					"id": 1,
					"path": "/data",
					"label": "media",
					"freeSpace": 1000000000,
					"totalSpace": 2000000000
				}
			]
			"""#.utf8
		)

		let diskSpaces = try client.decoder.decode([DiskSpaceResource].self, from: json)

		#expect(diskSpaces.count == 1)

		let diskSpace = try #require(diskSpaces.first)
		#expect(diskSpace.id == 1)
		#expect(diskSpace.path == "/data")
		#expect(diskSpace.label == "media")
		#expect(diskSpace.freeSpace == 1_000_000_000)
		#expect(diskSpace.totalSpace == 2_000_000_000)
	}

	@Test func diskSpaceResourceDecodingWithNullableFields() throws {
		let json = Data(
			#"""
			{
				"id": 2,
				"path": null,
				"label": null,
				"freeSpace": 0,
				"totalSpace": 0
			}
			"""#.utf8
		)

		let diskSpace = try client.decoder.decode(DiskSpaceResource.self, from: json)

		#expect(diskSpace.id == 2)
		#expect(diskSpace.path == nil)
		#expect(diskSpace.label == nil)
		#expect(diskSpace.freeSpace == 0)
		#expect(diskSpace.totalSpace == 0)
	}
}
