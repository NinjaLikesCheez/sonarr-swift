import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("QualityProfile requests")
struct QualityProfileRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleQualityProfile: QualityProfileResource {
		QualityProfileResource(
			id: 1,
			name: "HD-1080p",
			upgradeAllowed: true,
			cutoff: 9,
			items: [
				QualityProfileQualityItemResource(
					quality: Quality(id: 9, name: "HDTV-1080p", source: "television", resolution: 1080),
					items: [],
					allowed: true
				),
				QualityProfileQualityItemResource(
					id: 1000,
					name: "WEB 1080p",
					items: [
						QualityProfileQualityItemResource(
							quality: Quality(id: 3, name: "WEBDL-1080p", source: "web", resolution: 1080),
							items: [],
							allowed: true
						)
					],
					allowed: true
				),
			],
			minFormatScore: 0,
			cutoffFormatScore: 0,
			minUpgradeFormatScore: 1,
			formatItems: []
		)
	}

	@Test func qualityProfilesRequestConstruction() {
		let request = SonarrRequest.qualityProfiles

		#expect(request.method == .get)
		#expect(request.path == "api/v3/qualityprofile")
	}

	@Test func qualityProfileByIdRequestConstruction() {
		let request = SonarrRequest.qualityProfile(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/qualityprofile/1")
	}

	@Test func addQualityProfileRequestConstruction() throws {
		let request = SonarrRequest.addQualityProfile(sampleQualityProfile)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/qualityprofile")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["name"] as? String == "HD-1080p")
		#expect(json["upgradeAllowed"] as? Bool == true)
		#expect(json["cutoff"] as? Int == 9)
		#expect(json["minFormatScore"] as? Int == 0)
		#expect(json["cutoffFormatScore"] as? Int == 0)
		#expect(json["minUpgradeFormatScore"] as? Int == 1)
		#expect((json["formatItems"] as? [[String: Any]])?.isEmpty == true)

		let items = try #require(json["items"] as? [[String: Any]])
		#expect(items.count == 2)

		let leafItem = try #require(items.first)
		let leafQuality = try #require(leafItem["quality"] as? [String: Any])
		#expect(leafQuality["id"] as? Int == 9)
		#expect(leafQuality["name"] as? String == "HDTV-1080p")
		#expect(leafQuality["source"] as? String == "television")
		#expect(leafQuality["resolution"] as? Int == 1080)
		#expect(leafItem["allowed"] as? Bool == true)
		#expect((leafItem["items"] as? [[String: Any]])?.isEmpty == true)

		let groupItem = try #require(items.last)
		#expect(groupItem["id"] as? Int == 1000)
		#expect(groupItem["name"] as? String == "WEB 1080p")
		#expect(groupItem["allowed"] as? Bool == true)

		let groupNestedItems = try #require(groupItem["items"] as? [[String: Any]])
		#expect(groupNestedItems.count == 1)
		let nestedQuality = try #require(groupNestedItems.first?["quality"] as? [String: Any])
		#expect(nestedQuality["id"] as? Int == 3)
		#expect(nestedQuality["name"] as? String == "WEBDL-1080p")
		#expect(nestedQuality["source"] as? String == "web")
		#expect(nestedQuality["resolution"] as? Int == 1080)
	}

	@Test func updateQualityProfileRequestConstruction() throws {
		let request = SonarrRequest.updateQualityProfile(id: 1, sampleQualityProfile)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/qualityprofile/1")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["name"] as? String == "HD-1080p")
		#expect(json["upgradeAllowed"] as? Bool == true)
		#expect(json["cutoff"] as? Int == 9)
		#expect(json["minFormatScore"] as? Int == 0)
		#expect(json["cutoffFormatScore"] as? Int == 0)
		#expect(json["minUpgradeFormatScore"] as? Int == 1)
		#expect((json["formatItems"] as? [[String: Any]])?.isEmpty == true)

		let items = try #require(json["items"] as? [[String: Any]])
		#expect(items.count == 2)

		let leafItem = try #require(items.first)
		let leafQuality = try #require(leafItem["quality"] as? [String: Any])
		#expect(leafQuality["id"] as? Int == 9)
		#expect(leafQuality["name"] as? String == "HDTV-1080p")
		#expect(leafQuality["source"] as? String == "television")
		#expect(leafQuality["resolution"] as? Int == 1080)
		#expect(leafItem["allowed"] as? Bool == true)
		#expect((leafItem["items"] as? [[String: Any]])?.isEmpty == true)

		let groupItem = try #require(items.last)
		#expect(groupItem["id"] as? Int == 1000)
		#expect(groupItem["name"] as? String == "WEB 1080p")
		#expect(groupItem["allowed"] as? Bool == true)

		let groupNestedItems = try #require(groupItem["items"] as? [[String: Any]])
		#expect(groupNestedItems.count == 1)
		let nestedQuality = try #require(groupNestedItems.first?["quality"] as? [String: Any])
		#expect(nestedQuality["id"] as? Int == 3)
		#expect(nestedQuality["name"] as? String == "WEBDL-1080p")
		#expect(nestedQuality["source"] as? String == "web")
		#expect(nestedQuality["resolution"] as? Int == 1080)
	}

	@Test func deleteQualityProfileRequestConstruction() {
		let request = SonarrRequest.deleteQualityProfile(id: 1)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/qualityprofile/1")
	}

	@Test func qualityProfileSchemaRequestConstruction() {
		let request = SonarrRequest.qualityProfileSchema

		#expect(request.method == .get)
		#expect(request.path == "api/v3/qualityprofile/schema")
	}

	@Test func qualityProfileResourceDecodingWithNestedGroups() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"name": "Any",
				"upgradeAllowed": false,
				"cutoff": 1,
				"items": [
					{
						"quality": {
							"id": 1,
							"name": "SDTV",
							"source": "television",
							"resolution": 480
						},
						"items": [],
						"allowed": true
					},
					{
						"name": "WEB 1080p",
						"items": [
							{
								"quality": {
									"id": 15,
									"name": "WEBRip-1080p",
									"source": "webRip",
									"resolution": 1080
								},
								"items": [],
								"allowed": true
							},
							{
								"quality": {
									"id": 3,
									"name": "WEBDL-1080p",
									"source": "web",
									"resolution": 1080
								},
								"items": [],
								"allowed": true
							}
						],
						"allowed": true,
						"id": 1002
					}
				],
				"minFormatScore": 0,
				"cutoffFormatScore": 0,
				"minUpgradeFormatScore": 1,
				"formatItems": []
			}
			"""#.utf8
		)

		let profile = try client.decoder.decode(QualityProfileResource.self, from: json)

		#expect(profile.id == 1)
		#expect(profile.name == "Any")
		#expect(profile.cutoff == 1)
		#expect(profile.items?.count == 2)

		let leafItem = try #require(profile.items?.first)
		#expect(leafItem.quality?.name == "SDTV")
		#expect(leafItem.items?.isEmpty == true)

		let groupItem = try #require(profile.items?.last)
		#expect(groupItem.id == 1002)
		#expect(groupItem.name == "WEB 1080p")
		#expect(groupItem.items?.count == 2)
		#expect(groupItem.items?.first?.quality?.name == "WEBRip-1080p")
	}

	@Test func qualityProfileResourceDecodingWithNullableFields() throws {
		let json = Data(
			#"""
			{
				"id": 2,
				"name": null,
				"items": null,
				"formatItems": null
			}
			"""#.utf8
		)

		let profile = try client.decoder.decode(QualityProfileResource.self, from: json)

		#expect(profile.id == 2)
		#expect(profile.name == nil)
		#expect(profile.items == nil)
		#expect(profile.formatItems == nil)
	}
}
