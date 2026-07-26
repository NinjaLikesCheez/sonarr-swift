import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("CustomFormat requests")
struct CustomFormatRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private let sampleSpecification = CustomFormatSpecificationSchema(
		id: 1,
		name: "Surround Sound",
		implementation: "ReleaseTitleSpecification",
		implementationName: "Release Title",
		infoLink: "https://wiki.servarr.com/sonarr/settings#custom-formats",
		negate: false,
		required: true,
		fields: nil
	)

	private var sampleCustomFormat: CustomFormatResource {
		CustomFormatResource(
			id: 1,
			name: "Surround Sound",
			includeCustomFormatWhenRenaming: false,
			specifications: [sampleSpecification]
		)
	}

	@Test func customFormatsRequestConstruction() {
		let request = SonarrRequest.customFormats

		#expect(request.method == .get)
		#expect(request.path == "api/v3/customformat")
	}

	@Test func customFormatRequestConstruction() {
		let request = SonarrRequest.customFormat(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/customformat/1")
	}

	@Test func addCustomFormatRequestConstruction() throws {
		let request = SonarrRequest.addCustomFormat(sampleCustomFormat)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/customformat")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["name"] as? String == "Surround Sound")
		#expect(json["includeCustomFormatWhenRenaming"] as? Bool == false)

		let specifications = try #require(json["specifications"] as? [[String: Any]])
		#expect(specifications.count == 1)
		let specification = try #require(specifications.first)
		#expect(specification["id"] as? Int == 1)
		#expect(specification["name"] as? String == "Surround Sound")
		#expect(specification["implementation"] as? String == "ReleaseTitleSpecification")
		#expect(specification["implementationName"] as? String == "Release Title")
		#expect(specification["infoLink"] as? String == "https://wiki.servarr.com/sonarr/settings#custom-formats")
		#expect(specification["negate"] as? Bool == false)
		#expect(specification["required"] as? Bool == true)
	}

	@Test func updateCustomFormatRequestConstruction() throws {
		let request = SonarrRequest.updateCustomFormat(id: 1, sampleCustomFormat)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/customformat/1")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["name"] as? String == "Surround Sound")
		#expect(json["includeCustomFormatWhenRenaming"] as? Bool == false)

		let specifications = try #require(json["specifications"] as? [[String: Any]])
		#expect(specifications.count == 1)
		let specification = try #require(specifications.first)
		#expect(specification["id"] as? Int == 1)
		#expect(specification["name"] as? String == "Surround Sound")
		#expect(specification["implementation"] as? String == "ReleaseTitleSpecification")
		#expect(specification["implementationName"] as? String == "Release Title")
		#expect(specification["infoLink"] as? String == "https://wiki.servarr.com/sonarr/settings#custom-formats")
		#expect(specification["negate"] as? Bool == false)
		#expect(specification["required"] as? Bool == true)
	}

	@Test func deleteCustomFormatRequestConstruction() {
		let request = SonarrRequest.deleteCustomFormat(id: 1)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/customformat/1")
	}

	@Test func updateCustomFormatsRequestConstruction() throws {
		let request = SonarrRequest.updateCustomFormats(ids: [1, 2, 3], includeCustomFormatWhenRenaming: true)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/customformat/bulk")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["ids"] as? [Int] == [1, 2, 3])
		#expect(json["includeCustomFormatWhenRenaming"] as? Bool == true)
	}

	@Test func deleteCustomFormatsRequestConstruction() throws {
		let request = SonarrRequest.deleteCustomFormats(ids: [1, 2, 3])

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/customformat/bulk")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["ids"] as? [Int] == [1, 2, 3])
		#expect(json.keys.contains("includeCustomFormatWhenRenaming") == false)
	}

	@Test func customFormatSchemaRequestConstruction() {
		let request = SonarrRequest.customFormatSchema

		#expect(request.method == .get)
		#expect(request.path == "api/v3/customformat/schema")
	}

	@Test func customFormatResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"name": "Surround Sound",
				"includeCustomFormatWhenRenaming": false,
				"specifications": [
					{
						"id": 1,
						"name": "Surround Sound",
						"implementation": "ReleaseTitleSpecification",
						"implementationName": "Release Title",
						"infoLink": "https://wiki.servarr.com/sonarr/settings#custom-formats",
						"negate": false,
						"required": true,
						"fields": []
					}
				]
			}
			"""#.utf8
		)

		let customFormat = try client.decoder.decode(CustomFormatResource.self, from: json)

		#expect(customFormat.id == 1)
		#expect(customFormat.name == "Surround Sound")
		#expect(customFormat.includeCustomFormatWhenRenaming == false)
		#expect(customFormat.specifications?.count == 1)
		#expect(customFormat.specifications?.first?.implementation == "ReleaseTitleSpecification")
		#expect(customFormat.specifications?.first?.required == true)
	}

	@Test func customFormatResourceListDecoding() throws {
		let json = Data(
			#"""
			[
				{
					"id": 1,
					"name": "Surround Sound",
					"includeCustomFormatWhenRenaming": false,
					"specifications": []
				}
			]
			"""#.utf8
		)

		let customFormats = try client.decoder.decode([CustomFormatResource].self, from: json)

		#expect(customFormats.count == 1)
		#expect(customFormats.first?.name == "Surround Sound")
		#expect(customFormats.first?.specifications?.isEmpty == true)
	}

	@Test func customFormatSpecificationSchemaDecodingWithPresets() throws {
		let json = Data(
			#"""
			{
				"id": 2,
				"name": "Language",
				"implementation": "LanguageSpecification",
				"implementationName": "Language",
				"infoLink": null,
				"negate": false,
				"required": false,
				"fields": [],
				"presets": [
					{
						"name": "English",
						"implementation": "LanguageSpecification",
						"implementationName": "Language",
						"infoLink": null,
						"negate": false,
						"required": false,
						"fields": []
					}
				]
			}
			"""#.utf8
		)

		let specification = try client.decoder.decode(CustomFormatSpecificationSchema.self, from: json)

		#expect(specification.name == "Language")
		#expect(specification.presets?.count == 1)
		#expect(specification.presets?.first?.name == "English")
	}
}
