import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("DelayProfile requests")
struct DelayProfileRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleDelayProfile: DelayProfileResource {
		DelayProfileResource(
			id: 1,
			enableUsenet: true,
			enableTorrent: true,
			preferredProtocol: .usenet,
			usenetDelay: 0,
			torrentDelay: 0,
			bypassIfHighestQuality: false,
			bypassIfAboveCustomFormatScore: false,
			minimumCustomFormatScore: 0,
			order: 1,
			tags: []
		)
	}

	@Test func delayProfilesRequestConstruction() {
		let request = SonarrRequest.delayProfiles

		#expect(request.method == .get)
		#expect(request.path == "api/v3/delayprofile")
	}

	@Test func delayProfileRequestConstruction() {
		let request = SonarrRequest.delayProfile(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/delayprofile/1")
	}

	@Test func addDelayProfileRequestConstruction() throws {
		let request = SonarrRequest.addDelayProfile(sampleDelayProfile)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/delayprofile")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(DelayProfileResource.self, from: try body.encode())
		#expect(decoded == sampleDelayProfile)
	}

	@Test func updateDelayProfileRequestConstruction() throws {
		let request = SonarrRequest.updateDelayProfile(id: 1, sampleDelayProfile)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/delayprofile/1")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(DelayProfileResource.self, from: try body.encode())
		#expect(decoded == sampleDelayProfile)
	}

	@Test func deleteDelayProfileRequestConstruction() {
		let request = SonarrRequest.deleteDelayProfile(id: 1)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/delayprofile/1")
	}

	@Test func reorderDelayProfileRequestConstruction() {
		let request = SonarrRequest.reorderDelayProfile(id: 1, after: 2)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/delayprofile/reorder/1")

		let prepared = request.prepare(URLRequest(url: URL(string: "http://localhost:8989/api/v3/delayprofile/reorder/1")!))
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == [URLQueryItem(name: "after", value: "2")])
	}

	@Test func reorderDelayProfileRequestConstructionWithoutAfter() {
		let request = SonarrRequest.reorderDelayProfile(id: 1)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/delayprofile/reorder/1")

		let prepared = request.prepare(URLRequest(url: URL(string: "http://localhost:8989/api/v3/delayprofile/reorder/1")!))
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == nil)
	}

	@Test func delayProfileResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"enableUsenet": true,
				"enableTorrent": true,
				"preferredProtocol": "usenet",
				"usenetDelay": 0,
				"torrentDelay": 0,
				"bypassIfHighestQuality": false,
				"bypassIfAboveCustomFormatScore": false,
				"minimumCustomFormatScore": 0,
				"order": 1,
				"tags": []
			}
			"""#.utf8
		)

		let delayProfile = try client.decoder.decode(DelayProfileResource.self, from: json)

		#expect(delayProfile.id == 1)
		#expect(delayProfile.enableUsenet == true)
		#expect(delayProfile.enableTorrent == true)
		#expect(delayProfile.preferredProtocol == .usenet)
		#expect(delayProfile.order == 1)
		#expect(delayProfile.tags?.isEmpty == true)
	}

	@Test func delayProfileResourceListDecoding() throws {
		let json = Data(
			#"""
			[
				{
					"id": 1,
					"enableUsenet": true,
					"enableTorrent": false,
					"preferredProtocol": "usenet",
					"usenetDelay": 10,
					"torrentDelay": 0,
					"bypassIfHighestQuality": true,
					"bypassIfAboveCustomFormatScore": false,
					"minimumCustomFormatScore": 0,
					"order": 1,
					"tags": [1, 2]
				}
			]
			"""#.utf8
		)

		let delayProfiles = try client.decoder.decode([DelayProfileResource].self, from: json)

		#expect(delayProfiles.count == 1)
		#expect(delayProfiles.first?.usenetDelay == 10)
		#expect(delayProfiles.first?.tags == [1, 2])
	}
}
