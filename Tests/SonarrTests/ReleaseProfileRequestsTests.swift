import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("ReleaseProfile requests")
struct ReleaseProfileRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleReleaseProfile: ReleaseProfileResource {
		ReleaseProfileResource(
			id: 1,
			name: "No French",
			enabled: true,
			required: ["1080p"],
			ignored: ["FRENCH", "TRUEFRENCH"],
			indexerId: 0,
			tags: []
		)
	}

	@Test func releaseProfilesRequestConstruction() {
		let request = SonarrRequest.releaseProfiles

		#expect(request.method == .get)
		#expect(request.path == "api/v3/releaseprofile")
	}

	@Test func releaseProfileRequestConstruction() {
		let request = SonarrRequest.releaseProfile(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/releaseprofile/1")
	}

	@Test func addReleaseProfileRequestConstruction() throws {
		let request = SonarrRequest.addReleaseProfile(sampleReleaseProfile)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/releaseprofile")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["name"] as? String == "No French")
		#expect(json["enabled"] as? Bool == true)
		#expect(json["required"] as? [String] == ["1080p"])
		#expect(json["ignored"] as? [String] == ["FRENCH", "TRUEFRENCH"])
		#expect(json["indexerId"] as? Int == 0)
		#expect(json["tags"] as? [Int] == [])
	}

	@Test func updateReleaseProfileRequestConstruction() throws {
		let request = SonarrRequest.updateReleaseProfile(id: 1, sampleReleaseProfile)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/releaseprofile/1")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["name"] as? String == "No French")
		#expect(json["enabled"] as? Bool == true)
		#expect(json["required"] as? [String] == ["1080p"])
		#expect(json["ignored"] as? [String] == ["FRENCH", "TRUEFRENCH"])
		#expect(json["indexerId"] as? Int == 0)
		#expect(json["tags"] as? [Int] == [])
	}

	@Test func deleteReleaseProfileRequestConstruction() {
		let request = SonarrRequest.deleteReleaseProfile(id: 1)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/releaseprofile/1")
	}

	@Test func releaseProfileResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"name": "No French",
				"enabled": true,
				"required": ["1080p"],
				"ignored": ["FRENCH", "TRUEFRENCH"],
				"indexerId": 0,
				"tags": []
			}
			"""#.utf8
		)

		let releaseProfile = try client.decoder.decode(ReleaseProfileResource.self, from: json)

		#expect(releaseProfile.id == 1)
		#expect(releaseProfile.name == "No French")
		#expect(releaseProfile.enabled == true)
		#expect(releaseProfile.required == ["1080p"])
		#expect(releaseProfile.ignored == ["FRENCH", "TRUEFRENCH"])
		#expect(releaseProfile.indexerId == 0)
		#expect(releaseProfile.tags?.isEmpty == true)
	}

	@Test func releaseProfileResourceDecodingWithNullableFieldsMissing() throws {
		let json = Data(
			#"""
			{
				"id": 2
			}
			"""#.utf8
		)

		let releaseProfile = try client.decoder.decode(ReleaseProfileResource.self, from: json)

		#expect(releaseProfile.id == 2)
		#expect(releaseProfile.name == nil)
		#expect(releaseProfile.required == nil)
		#expect(releaseProfile.ignored == nil)
		#expect(releaseProfile.tags == nil)
	}

	@Test func releaseProfileResourceListDecoding() throws {
		let json = Data(
			#"""
			[
				{
					"id": 1,
					"name": "No French",
					"enabled": true,
					"required": [],
					"ignored": [],
					"indexerId": 0,
					"tags": [1, 2]
				}
			]
			"""#.utf8
		)

		let releaseProfiles = try client.decoder.decode([ReleaseProfileResource].self, from: json)

		#expect(releaseProfiles.count == 1)
		#expect(releaseProfiles.first?.name == "No French")
		#expect(releaseProfiles.first?.tags == [1, 2])
	}
}
