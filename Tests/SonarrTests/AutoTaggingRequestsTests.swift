import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("AutoTagging requests")
struct AutoTaggingRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private let sampleAutoTagging = AutoTaggingResource(
		id: 1,
		name: "Anime",
		removeTagsAutomatically: true,
		tags: [3],
		specifications: [
			AutoTaggingSpecificationSchema(
				id: 2,
				name: "Is Anime",
				implementation: "SeriesTypeSpecification",
				implementationName: "Series Type",
				negate: false,
				required: true,
				fields: nil
			)
		]
	)

	@Test func autoTaggingsRequestConstruction() {
		let request = SonarrRequest.autoTaggings

		#expect(request.method == .get)
		#expect(request.path == "api/v3/autotagging")
	}

	@Test func autoTaggingRequestConstruction() {
		let request = SonarrRequest.autoTagging(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/autotagging/1")
	}

	@Test func addAutoTaggingRequestConstruction() throws {
		let request = SonarrRequest.addAutoTagging(sampleAutoTagging)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/autotagging")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["name"] as? String == "Anime")
		#expect(json["removeTagsAutomatically"] as? Bool == true)
		#expect(json["tags"] as? [Int] == [3])
		let specifications = try #require(json["specifications"] as? [[String: Any]])
		#expect(specifications.count == 1)
		#expect(specifications.first?["id"] as? Int == 2)
		#expect(specifications.first?["name"] as? String == "Is Anime")
		#expect(specifications.first?["implementation"] as? String == "SeriesTypeSpecification")
		#expect(specifications.first?["implementationName"] as? String == "Series Type")
		#expect(specifications.first?["negate"] as? Bool == false)
		#expect(specifications.first?["required"] as? Bool == true)
	}

	@Test func updateAutoTaggingRequestConstruction() throws {
		let request = SonarrRequest.updateAutoTagging(id: 1, sampleAutoTagging)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/autotagging/1")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["name"] as? String == "Anime")
		#expect(json["removeTagsAutomatically"] as? Bool == true)
		#expect(json["tags"] as? [Int] == [3])
		let specifications = try #require(json["specifications"] as? [[String: Any]])
		#expect(specifications.count == 1)
		#expect(specifications.first?["id"] as? Int == 2)
		#expect(specifications.first?["name"] as? String == "Is Anime")
		#expect(specifications.first?["implementation"] as? String == "SeriesTypeSpecification")
		#expect(specifications.first?["implementationName"] as? String == "Series Type")
		#expect(specifications.first?["negate"] as? Bool == false)
		#expect(specifications.first?["required"] as? Bool == true)
	}

	@Test func deleteAutoTaggingRequestConstruction() {
		let request = SonarrRequest.deleteAutoTagging(id: 1)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/autotagging/1")
	}

	@Test func autoTaggingSchemaRequestConstruction() {
		let request = SonarrRequest.autoTaggingSchema

		#expect(request.method == .get)
		#expect(request.path == "api/v3/autotagging/schema")
	}

	@Test func autoTaggingResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"name": "Anime",
				"removeTagsAutomatically": true,
				"tags": [3],
				"specifications": [
					{
						"id": 2,
						"name": "Is Anime",
						"implementation": "SeriesTypeSpecification",
						"implementationName": "Series Type",
						"negate": false,
						"required": true,
						"fields": [
							{
								"order": 0,
								"name": "value",
								"label": "Value",
								"value": 2,
								"type": "select",
								"advanced": false,
								"privacy": "normal",
								"isFloat": false
							}
						]
					}
				]
			}
			"""#.utf8
		)

		let autoTagging = try client.decoder.decode(AutoTaggingResource.self, from: json)

		#expect(autoTagging.id == 1)
		#expect(autoTagging.name == "Anime")
		#expect(autoTagging.removeTagsAutomatically == true)
		#expect(autoTagging.tags == [3])
		#expect(autoTagging.specifications?.count == 1)

		let specification = try #require(autoTagging.specifications?.first)
		#expect(specification.implementation == "SeriesTypeSpecification")
		#expect(specification.required == true)

		let field = try #require(specification.fields?.first)
		#expect(field.name == "value")
		#expect(field.value == .int(2))
		#expect(field.privacy == .normal)
	}

	@Test func autoTaggingSpecificationSchemaListDecoding() throws {
		let json = Data(
			#"""
			[
				{
					"name": "Series Type",
					"implementation": "SeriesTypeSpecification",
					"implementationName": "Series Type",
					"negate": false,
					"required": false,
					"fields": []
				}
			]
			"""#.utf8
		)

		let schema = try client.decoder.decode([AutoTaggingSpecificationSchema].self, from: json)

		#expect(schema.count == 1)
		#expect(schema.first?.implementation == "SeriesTypeSpecification")
		#expect(schema.first?.fields?.isEmpty == true)
	}
}
