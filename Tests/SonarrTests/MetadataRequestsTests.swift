import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("Metadata requests")
struct MetadataRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleMetadataConsumer: MetadataResource {
		MetadataResource(
			id: 1,
			name: "Kodi",
			implementationName: "Kodi (XBMC) / Emby",
			implementation: "XbmcMetadata",
			configContract: "XbmcMetadataSettings",
			infoLink: "https://wiki.servarr.com/sonarr/settings#metadata",
			tags: [],
			enable: true
		)
	}

	@Test func metadataConsumersRequestConstruction() {
		let request = SonarrRequest.metadataConsumers

		#expect(request.method == .get)
		#expect(request.path == "api/v3/metadata")
	}

	@Test func metadataConsumerRequestConstruction() {
		let request = SonarrRequest.metadataConsumer(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/metadata/1")
	}

	@Test func addMetadataConsumerRequestConstruction() throws {
		let request = SonarrRequest.addMetadataConsumer(sampleMetadataConsumer, forceSave: true)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/metadata")

		let prepared = request.prepare(URLRequest(url: URL(string: "http://localhost:8989/api/v3/metadata")!))
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == [URLQueryItem(name: "forceSave", value: "true")])

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["name"] as? String == "Kodi")
		#expect(json["implementationName"] as? String == "Kodi (XBMC) / Emby")
		#expect(json["implementation"] as? String == "XbmcMetadata")
		#expect(json["configContract"] as? String == "XbmcMetadataSettings")
		#expect(json["infoLink"] as? String == "https://wiki.servarr.com/sonarr/settings#metadata")
		#expect(json["tags"] as? [Int] == [])
		#expect(json["enable"] as? Bool == true)
	}

	@Test func addMetadataConsumerRequestConstructionDefaultsForceSaveFalse() {
		let request = SonarrRequest.addMetadataConsumer(sampleMetadataConsumer)

		let prepared = request.prepare(URLRequest(url: URL(string: "http://localhost:8989/api/v3/metadata")!))
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == [URLQueryItem(name: "forceSave", value: "false")])
	}

	@Test func updateMetadataConsumerRequestConstruction() throws {
		let request = SonarrRequest.updateMetadataConsumer(id: 1, sampleMetadataConsumer, forceSave: true)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/metadata/1")

		let prepared = request.prepare(URLRequest(url: URL(string: "http://localhost:8989/api/v3/metadata/1")!))
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == [URLQueryItem(name: "forceSave", value: "true")])

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["name"] as? String == "Kodi")
		#expect(json["implementationName"] as? String == "Kodi (XBMC) / Emby")
		#expect(json["implementation"] as? String == "XbmcMetadata")
		#expect(json["configContract"] as? String == "XbmcMetadataSettings")
		#expect(json["infoLink"] as? String == "https://wiki.servarr.com/sonarr/settings#metadata")
		#expect(json["tags"] as? [Int] == [])
		#expect(json["enable"] as? Bool == true)
	}

	@Test func deleteMetadataConsumerRequestConstruction() {
		let request = SonarrRequest.deleteMetadataConsumer(id: 1)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/metadata/1")
	}

	@Test func metadataConsumerSchemaRequestConstruction() {
		let request = SonarrRequest.metadataConsumerSchema

		#expect(request.method == .get)
		#expect(request.path == "api/v3/metadata/schema")
	}

	@Test func testMetadataConsumerRequestConstruction() throws {
		let request = SonarrRequest.testMetadataConsumer(sampleMetadataConsumer, forceTest: true)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/metadata/test")

		let prepared = request.prepare(URLRequest(url: URL(string: "http://localhost:8989/api/v3/metadata/test")!))
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == [URLQueryItem(name: "forceTest", value: "true")])

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["name"] as? String == "Kodi")
		#expect(json["implementationName"] as? String == "Kodi (XBMC) / Emby")
		#expect(json["implementation"] as? String == "XbmcMetadata")
		#expect(json["configContract"] as? String == "XbmcMetadataSettings")
		#expect(json["infoLink"] as? String == "https://wiki.servarr.com/sonarr/settings#metadata")
		#expect(json["tags"] as? [Int] == [])
		#expect(json["enable"] as? Bool == true)
	}

	@Test func testAllMetadataConsumersRequestConstruction() {
		let request = SonarrRequest.testAllMetadataConsumers

		#expect(request.method == .post)
		#expect(request.path == "api/v3/metadata/testall")
	}

	@Test func performMetadataConsumerActionRequestConstruction() throws {
		let request = SonarrRequest.performMetadataConsumerAction(name: "checkForUpdates", sampleMetadataConsumer)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/metadata/action/checkForUpdates")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["id"] as? Int == 1)
		#expect(json["name"] as? String == "Kodi")
		#expect(json["implementationName"] as? String == "Kodi (XBMC) / Emby")
		#expect(json["implementation"] as? String == "XbmcMetadata")
		#expect(json["configContract"] as? String == "XbmcMetadataSettings")
		#expect(json["infoLink"] as? String == "https://wiki.servarr.com/sonarr/settings#metadata")
		#expect(json["tags"] as? [Int] == [])
		#expect(json["enable"] as? Bool == true)
	}

	@Test func metadataResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"name": "Kodi",
				"fields": [],
				"implementationName": "Kodi (XBMC) / Emby",
				"implementation": "XbmcMetadata",
				"configContract": "XbmcMetadataSettings",
				"infoLink": "https://wiki.servarr.com/sonarr/settings#metadata",
				"message": {
					"message": "Some info",
					"type": "info"
				},
				"tags": [1, 2],
				"enable": true
			}
			"""#.utf8
		)

		let metadataConsumer = try client.decoder.decode(MetadataResource.self, from: json)

		#expect(metadataConsumer.id == 1)
		#expect(metadataConsumer.name == "Kodi")
		#expect(metadataConsumer.implementation == "XbmcMetadata")
		#expect(metadataConsumer.message?.message == "Some info")
		#expect(metadataConsumer.message?.type == .info)
		#expect(metadataConsumer.tags == [1, 2])
		#expect(metadataConsumer.enable == true)
	}

	@Test func metadataResourceListDecodingWithPresets() throws {
		let json = Data(
			#"""
			[
				{
					"name": "Roksbox",
					"implementationName": "Roksbox",
					"implementation": "RoksboxMetadata",
					"configContract": "RoksboxMetadataSettings",
					"infoLink": null,
					"fields": [],
					"enable": false,
					"presets": [
						{
							"name": "Roksbox",
							"implementationName": "Roksbox",
							"implementation": "RoksboxMetadata",
							"configContract": "RoksboxMetadataSettings",
							"infoLink": null,
							"fields": [],
							"enable": false
						}
					]
				}
			]
			"""#.utf8
		)

		let metadataConsumers = try client.decoder.decode([MetadataResource].self, from: json)

		#expect(metadataConsumers.count == 1)
		#expect(metadataConsumers.first?.presets?.count == 1)
		#expect(metadataConsumers.first?.presets?.first?.implementation == "RoksboxMetadata")
	}
}
