import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("Command requests")
struct CommandRequestsTests {
	let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	@Test func commandByNameRequestConstruction() throws {
		let request = SonarrRequest.command(name: "RssSync")

		#expect(request.method == .post)
		#expect(request.path == "api/v3/command")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: String])

		#expect(json["name"] == "RssSync")
	}

	@Test func refreshSeriesRequestConstruction() throws {
		let request = SonarrRequest.refreshSeries(seriesIds: [1, 2])

		#expect(request.method == .post)
		#expect(request.path == "api/v3/command")

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["name"] as? String == "RefreshSeries")
		#expect(json["seriesIds"] as? [Int] == [1, 2])
	}

	@Test func refreshSeriesRequestConstructionWithNoSeries() throws {
		let request = SonarrRequest.refreshSeries()

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["seriesIds"] as? [Int] == [])
	}

	@Test func rescanSeriesRequestConstruction() throws {
		let request = SonarrRequest.rescanSeries(seriesId: 5)

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["name"] as? String == "RescanSeries")
		#expect(json["seriesId"] as? Int == 5)
	}

	@Test func rescanSeriesRequestConstructionWithNoSeries() throws {
		let request = SonarrRequest.rescanSeries()

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["seriesId"] == nil)
	}

	@Test func seriesSearchRequestConstruction() throws {
		let request = SonarrRequest.seriesSearch(seriesId: 5)

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["name"] as? String == "SeriesSearch")
		#expect(json["seriesId"] as? Int == 5)
	}

	@Test func seasonSearchRequestConstruction() throws {
		let request = SonarrRequest.seasonSearch(seriesId: 5, seasonNumber: 2)

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["name"] as? String == "SeasonSearch")
		#expect(json["seriesId"] as? Int == 5)
		#expect(json["seasonNumber"] as? Int == 2)
	}

	@Test func episodeSearchRequestConstruction() throws {
		let request = SonarrRequest.episodeSearch(episodeIds: [10, 11])

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["name"] as? String == "EpisodeSearch")
		#expect(json["episodeIds"] as? [Int] == [10, 11])
	}

	@Test func missingEpisodeSearchRequestConstruction() throws {
		let request = SonarrRequest.missingEpisodeSearch(seriesId: 5)

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["name"] as? String == "MissingEpisodeSearch")
		#expect(json["seriesId"] as? Int == 5)
	}

	@Test func rssSyncRequestConstruction() throws {
		let request = SonarrRequest.rssSync

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: String])

		#expect(json["name"] == "RssSync")
	}

	@Test func renameFilesRequestConstruction() throws {
		let request = SonarrRequest.renameFiles(seriesId: 5, files: [1, 2])

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

		#expect(json["name"] as? String == "RenameFiles")
		#expect(json["seriesId"] as? Int == 5)
		#expect(json["files"] as? [Int] == [1, 2])
	}

	@Test func backupRequestConstruction() throws {
		let request = SonarrRequest.backup

		let body = try #require(try request.body())
		let data = try body.encode()
		let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: String])

		#expect(json["name"] == "Backup")
	}

	@Test func commandsRequestConstruction() {
		let request = SonarrRequest.commands

		#expect(request.method == .get)
		#expect(request.path == "api/v3/command")
	}

	@Test func commandByIdRequestConstruction() {
		let request = SonarrRequest.command(id: 42)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/command/42")
	}

	@Test func cancelCommandRequestConstruction() {
		let request = SonarrRequest.cancelCommand(id: 42)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/command/42")
	}

	@Test func commandResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"name": "RefreshSeries",
				"commandName": "Refresh Series",
				"message": "Completed",
				"priority": "normal",
				"status": "completed",
				"result": "successful",
				"queued": "2024-01-01T12:00:00Z",
				"started": "2024-01-01T12:00:01Z",
				"ended": "2024-01-01T12:00:05Z",
				"duration": "00:00:04.1234567",
				"trigger": "manual",
				"sendUpdatesToClient": true,
				"updateScheduledTask": true
			}
			"""#.utf8
		)

		let command = try client.decoder.decode(CommandResource.self, from: json)

		#expect(command.id == 1)
		#expect(command.name == "RefreshSeries")
		#expect(command.commandName == "Refresh Series")
		#expect(command.message == "Completed")
		#expect(command.priority == .normal)
		#expect(command.status == .completed)
		#expect(command.result == .successful)
		#expect(command.trigger == .manual)
		#expect(command.duration == "00:00:04.1234567")
		#expect(command.sendUpdatesToClient)
		#expect(command.updateScheduledTask)
	}

	@Test func commandResourceDecodingWithNullableFieldsMissing() throws {
		let json = Data(
			#"""
			{
				"id": 2,
				"name": "RssSync",
				"commandName": "Rss Sync",
				"priority": "normal",
				"status": "queued",
				"queued": "2024-01-01T12:00:00Z",
				"trigger": "scheduled",
				"sendUpdatesToClient": true,
				"updateScheduledTask": true
			}
			"""#.utf8
		)

		let command = try client.decoder.decode(CommandResource.self, from: json)

		#expect(command.message == nil)
		#expect(command.result == nil)
		#expect(command.started == nil)
		#expect(command.ended == nil)
		#expect(command.duration == nil)
		#expect(command.exception == nil)
	}
}
