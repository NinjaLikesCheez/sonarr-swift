import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

@Suite("Notification requests")
struct NotificationRequestsTests {
	private let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "test-api-key")

	private var sampleNotification: NotificationResource {
		NotificationResource(
			id: 1,
			name: "Discord",
			implementationName: "Discord",
			implementation: "Discord",
			configContract: "DiscordSettings",
			infoLink: "https://wiki.servarr.com/sonarr/settings#connect",
			tags: [],
			onGrab: true,
			onDownload: true,
			onUpgrade: false,
			supportsOnGrab: true,
			supportsOnDownload: true
		)
	}

	@Test func notificationsRequestConstruction() {
		let request = SonarrRequest.notifications

		#expect(request.method == .get)
		#expect(request.path == "api/v3/notification")
	}

	@Test func notificationRequestConstruction() {
		let request = SonarrRequest.notification(id: 1)

		#expect(request.method == .get)
		#expect(request.path == "api/v3/notification/1")
	}

	@Test func addNotificationRequestConstruction() throws {
		let request = SonarrRequest.addNotification(sampleNotification, forceSave: true)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/notification")

		let prepared = request.prepare(URLRequest(url: URL(string: "http://localhost:8989/api/v3/notification")!))
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == [URLQueryItem(name: "forceSave", value: "true")])

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(NotificationResource.self, from: try body.encode())
		#expect(decoded == sampleNotification)
	}

	@Test func addNotificationRequestConstructionDefaultsForceSaveFalse() {
		let request = SonarrRequest.addNotification(sampleNotification)

		let prepared = request.prepare(URLRequest(url: URL(string: "http://localhost:8989/api/v3/notification")!))
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == [URLQueryItem(name: "forceSave", value: "false")])
	}

	@Test func updateNotificationRequestConstruction() throws {
		let request = SonarrRequest.updateNotification(id: 1, sampleNotification, forceSave: true)

		#expect(request.method == .put)
		#expect(request.path == "api/v3/notification/1")

		let prepared = request.prepare(URLRequest(url: URL(string: "http://localhost:8989/api/v3/notification/1")!))
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == [URLQueryItem(name: "forceSave", value: "true")])

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(NotificationResource.self, from: try body.encode())
		#expect(decoded == sampleNotification)
	}

	@Test func deleteNotificationRequestConstruction() {
		let request = SonarrRequest.deleteNotification(id: 1)

		#expect(request.method == .delete)
		#expect(request.path == "api/v3/notification/1")
	}

	@Test func notificationSchemaRequestConstruction() {
		let request = SonarrRequest.notificationSchema

		#expect(request.method == .get)
		#expect(request.path == "api/v3/notification/schema")
	}

	@Test func testNotificationRequestConstruction() throws {
		let request = SonarrRequest.testNotification(sampleNotification, forceTest: true)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/notification/test")

		let prepared = request.prepare(
			URLRequest(url: URL(string: "http://localhost:8989/api/v3/notification/test")!)
		)
		let components = URLComponents(url: prepared.url!, resolvingAgainstBaseURL: false)
		#expect(components?.queryItems == [URLQueryItem(name: "forceTest", value: "true")])

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(NotificationResource.self, from: try body.encode())
		#expect(decoded == sampleNotification)
	}

	@Test func testAllNotificationsRequestConstruction() {
		let request = SonarrRequest.testAllNotifications

		#expect(request.method == .post)
		#expect(request.path == "api/v3/notification/testall")
	}

	@Test func performNotificationActionRequestConstruction() throws {
		let request = SonarrRequest.performNotificationAction(name: "checkForUpdates", sampleNotification)

		#expect(request.method == .post)
		#expect(request.path == "api/v3/notification/action/checkForUpdates")

		let body = try #require(try request.body())
		let decoded = try client.decoder.decode(NotificationResource.self, from: try body.encode())
		#expect(decoded == sampleNotification)
	}

	@Test func notificationResourceDecoding() throws {
		let json = Data(
			#"""
			{
				"id": 1,
				"name": "Discord",
				"fields": [],
				"implementationName": "Discord",
				"implementation": "Discord",
				"configContract": "DiscordSettings",
				"infoLink": "https://wiki.servarr.com/sonarr/settings#connect",
				"message": {
					"message": "Some info",
					"type": "info"
				},
				"tags": [1, 2],
				"onGrab": true,
				"onDownload": true,
				"onUpgrade": false,
				"onImportComplete": false,
				"onRename": false,
				"onSeriesAdd": false,
				"onSeriesDelete": false,
				"onEpisodeFileDelete": false,
				"onEpisodeFileDeleteForUpgrade": false,
				"onHealthIssue": false,
				"includeHealthWarnings": false,
				"onHealthRestored": false,
				"onApplicationUpdate": false,
				"onManualInteractionRequired": false,
				"supportsOnGrab": true,
				"supportsOnDownload": true,
				"supportsOnUpgrade": true,
				"supportsOnImportComplete": true,
				"supportsOnRename": true,
				"supportsOnSeriesAdd": true,
				"supportsOnSeriesDelete": true,
				"supportsOnEpisodeFileDelete": true,
				"supportsOnEpisodeFileDeleteForUpgrade": true,
				"supportsOnHealthIssue": true,
				"supportsOnHealthRestored": true,
				"supportsOnApplicationUpdate": true,
				"supportsOnManualInteractionRequired": true,
				"testCommand": null
			}
			"""#.utf8
		)

		let notification = try client.decoder.decode(NotificationResource.self, from: json)

		#expect(notification.id == 1)
		#expect(notification.name == "Discord")
		#expect(notification.implementation == "Discord")
		#expect(notification.message?.message == "Some info")
		#expect(notification.message?.type == .info)
		#expect(notification.tags == [1, 2])
		#expect(notification.onGrab == true)
		#expect(notification.onUpgrade == false)
		#expect(notification.supportsOnGrab == true)
		#expect(notification.testCommand == nil)
	}

	@Test func notificationResourceListDecodingWithPresets() throws {
		let json = Data(
			#"""
			[
				{
					"name": "Webhook",
					"implementationName": "Webhook",
					"implementation": "Webhook",
					"configContract": "WebhookSettings",
					"infoLink": null,
					"fields": [],
					"onGrab": false,
					"presets": [
						{
							"name": "Webhook",
							"implementationName": "Webhook",
							"implementation": "Webhook",
							"configContract": "WebhookSettings",
							"infoLink": null,
							"fields": [],
							"onGrab": false
						}
					]
				}
			]
			"""#.utf8
		)

		let notifications = try client.decoder.decode([NotificationResource].self, from: json)

		#expect(notifications.count == 1)
		#expect(notifications.first?.presets?.count == 1)
		#expect(notifications.first?.presets?.first?.implementation == "Webhook")
	}
}
