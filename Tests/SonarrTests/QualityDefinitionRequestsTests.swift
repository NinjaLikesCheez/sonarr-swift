import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("QualityDefinition requests")
struct QualityDefinitionRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleQualityDefinition: QualityDefinitionResource {
		QualityDefinitionResource(
			id: 1,
			quality: Quality(id: 3, name: "WEBDL-1080p", source: "web", resolution: 1080),
			title: "WEBDL-1080p",
			weight: 5,
			minSize: 1.0,
			maxSize: 199.9,
			preferredSize: 95.0
		)
	}

	@Test func qualityDefinitionsRequestConstruction() {
		let request = SonarrRequest.qualityDefinitions

		#expect(request.method == .get)
		#expect(request.path == "api/v3/qualitydefinition")
	}

	@Test func qualityDefinitionByIdRequestConstruction() {
		let request = SonarrRequest.qualityDefinition(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/qualitydefinition/1")
	}

	@Test func updateQualityDefinitionRequestConstruction() throws {
		let request = SonarrRequest.updateQualityDefinition(id: 1, sampleQualityDefinition)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/qualitydefinition/1")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["title"] as? String == "WEBDL-1080p")
		#expect(json["weight"] as? Int == 5)
		#expect(json["minSize"] as? Double == 1.0)
		#expect(json["maxSize"] as? Double == 199.9)
		#expect(json["preferredSize"] as? Double == 95.0)

		let quality = try #require(json["quality"] as? [String: Any])
		#expect(quality["id"] as? Int == 3)
		#expect(quality["name"] as? String == "WEBDL-1080p")
		#expect(quality["source"] as? String == "web")
		#expect(quality["resolution"] as? Int == 1080)
	}

	@Test func updateQualityDefinitionsRequestConstruction() throws {
		let definitions = [sampleQualityDefinition]
		let request = SonarrRequest.updateQualityDefinitions(definitions)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/qualitydefinition/update")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [[String: Any]])

		#expect(json.count == 1)

		let first = try #require(json.first)
		#expect(first["id"] as? Int == 1)
		#expect(first["title"] as? String == "WEBDL-1080p")
		#expect(first["weight"] as? Int == 5)
		#expect(first["minSize"] as? Double == 1.0)
		#expect(first["maxSize"] as? Double == 199.9)
		#expect(first["preferredSize"] as? Double == 95.0)
	}

	@Test func qualityDefinitionLimitsRequestConstruction() {
		let request = SonarrRequest.qualityDefinitionLimits

		#expect(request.method == .get)
		#expect(request.path == "api/v3/qualitydefinition/limits")
	}

	@Test func qualityDefinitionResourceListDecoding() throws {
		let json = Data(
			#"""
			[
				{
					"id": 1,
					"quality": {
						"id": 0,
						"name": "Unknown",
						"source": "unknown",
						"resolution": 0
					},
					"title": "Unknown",
					"weight": 1,
					"minSize": 1,
					"maxSize": 199.9,
					"preferredSize": 95
				}
			]
			"""#.utf8
		)

		let definitions = try client.decoder.decode([QualityDefinitionResource].self, from: json)

		#expect(definitions.count == 1)

		let definition = try #require(definitions.first)
		#expect(definition.id == 1)
		#expect(definition.quality?.name == "Unknown")
		#expect(definition.title == "Unknown")
		#expect(definition.weight == 1)
		#expect(definition.minSize == 1)
		#expect(definition.maxSize == 199.9)
		#expect(definition.preferredSize == 95)
	}

	@Test func qualityDefinitionResourceDecodingWithNullableFields() throws {
		let json = Data(
			#"""
			{
				"id": 2,
				"title": null,
				"minSize": null,
				"maxSize": null,
				"preferredSize": null
			}
			"""#.utf8
		)

		let definition = try client.decoder.decode(QualityDefinitionResource.self, from: json)

		#expect(definition.id == 2)
		#expect(definition.title == nil)
		#expect(definition.minSize == nil)
		#expect(definition.maxSize == nil)
		#expect(definition.preferredSize == nil)
	}

	@Test func qualityDefinitionLimitsResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"min": 0,
				"max": 1000
			}
			"""#.utf8
		)

		let limits = try client.decoder.decode(QualityDefinitionLimitsResource.self, from: json)

		#expect(limits.min == 0)
		#expect(limits.max == 1000)
	}
}
