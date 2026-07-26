import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("RemotePathMapping requests")
struct RemotePathMappingRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleRemotePathMapping: RemotePathMappingResource {
		RemotePathMappingResource(
			id: 1,
			host: "download-client",
			remotePath: "/remote/downloads/",
			localPath: "/local/downloads/"
		)
	}

	@Test func remotePathMappingsRequestConstruction() {
		let request = SonarrRequest.remotePathMappings

		#expect(request.method == .get)
		#expect(request.path == "api/v3/remotepathmapping")
	}

	@Test func remotePathMappingRequestConstruction() {
		let request = SonarrRequest.remotePathMapping(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/remotepathmapping/1")
	}

	@Test func addRemotePathMappingRequestConstruction() throws {
		let request = SonarrRequest.addRemotePathMapping(sampleRemotePathMapping)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/remotepathmapping")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["host"] as? String == "download-client")
		#expect(json["remotePath"] as? String == "/remote/downloads/")
		#expect(json["localPath"] as? String == "/local/downloads/")
	}

	@Test func updateRemotePathMappingRequestConstruction() throws {
		let request = SonarrRequest.updateRemotePathMapping(id: 1, sampleRemotePathMapping)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/remotepathmapping/1")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["host"] as? String == "download-client")
		#expect(json["remotePath"] as? String == "/remote/downloads/")
		#expect(json["localPath"] as? String == "/local/downloads/")
	}

	@Test func deleteRemotePathMappingRequestConstruction() {
		let request = SonarrRequest.deleteRemotePathMapping(id: 1)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/remotepathmapping/1")
	}

	@Test func remotePathMappingResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"host": "download-client",
				"remotePath": "/remote/downloads/",
				"localPath": "/local/downloads/"
			}
			"""#.utf8
		)

		let mapping = try client.decoder.decode(RemotePathMappingResource.self, from: json)

		#expect(mapping.id == 1)
		#expect(mapping.host == "download-client")
		#expect(mapping.remotePath == "/remote/downloads/")
		#expect(mapping.localPath == "/local/downloads/")
	}

	@Test func remotePathMappingResourceDecodingWithNullableFieldsMissing() throws {
		let json = Data(
			#"""
			{
				"id": 2
			}
			"""#.utf8
		)

		let mapping = try client.decoder.decode(RemotePathMappingResource.self, from: json)

		#expect(mapping.id == 2)
		#expect(mapping.host == nil)
		#expect(mapping.remotePath == nil)
		#expect(mapping.localPath == nil)
	}

	@Test func remotePathMappingResourceListDecoding() throws {
		let json = Data(
			#"""
			[
				{
					"id": 1,
					"host": "download-client",
					"remotePath": "/remote/downloads/",
					"localPath": "/local/downloads/"
				}
			]
			"""#.utf8
		)

		let mappings = try client.decoder.decode([RemotePathMappingResource].self, from: json)

		#expect(mappings.count == 1)
		#expect(mappings.first?.host == "download-client")
	}
}
