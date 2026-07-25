import Foundation
import Sonarr
import Testing

@Suite("Notification Requests", .serialized)
struct NotificationRequestsTests {
	// The schema endpoint returns a preset per implementation with its default fields already populated, but
	// most implementations validate their required fields (e.g. a URL) even with forceSave=true. Webhook only
	// requires its "url" field, so start from its preset and fill that one value in via a small JSON round-trip
	// (Field has no public initializer in this module).
	private static func webhookPreset() async throws -> NotificationResource {
		let schemas = try await client.request(.notificationSchema)
		return try #require(schemas.first(where: { $0.implementation == "Webhook" }))
	}

	private static func fieldsSettingURL(basedOn preset: NotificationResource) throws -> [Field] {
		let fields = preset.fields ?? []
		let json = try JSONEncoder().encode(fields)
		var objects = try JSONSerialization.jsonObject(with: json) as? [[String: Any]] ?? []

		if let urlIndex = objects.firstIndex(where: { $0["name"] as? String == "url" }) {
			objects[urlIndex]["value"] = "http://localhost:9999/webhook"
		}

		let updatedJSON = try JSONSerialization.data(withJSONObject: objects)
		return try client.decoder.decode([Field].self, from: updatedJSON)
	}

	private static func makeNotification(
		named name: String,
		basedOn preset: NotificationResource,
		fields: [Field],
		id: Int? = nil,
		onGrab: Bool = false
	) -> NotificationResource {
		NotificationResource(
			id: id,
			name: name,
			fields: fields,
			implementationName: preset.implementationName,
			implementation: preset.implementation,
			configContract: preset.configContract,
			infoLink: preset.infoLink,
			tags: [],
			onGrab: onGrab
		)
	}

	@Test
	func test_addNotification_notifications_notification_updateNotification_deleteNotification() async throws {
		let preset = try await Self.webhookPreset()
		let fields = try Self.fieldsSettingURL(basedOn: preset)

		let created = try await client.request(
			.addNotification(
				Self.makeNotification(named: "Integration Test Notification", basedOn: preset, fields: fields),
				forceSave: true
			)
		)

		let id = try #require(created.id)
		#expect(created.name == "Integration Test Notification")

		let notifications = try await client.request(.notifications)
		#expect(notifications.contains(where: { $0.id == id }))

		let fetched = try await client.request(.notification(id: id))
		#expect(fetched.id == id)

		let updated = try await client.request(
			.updateNotification(
				id: id,
				Self.makeNotification(
					named: "Integration Test Notification Renamed",
					basedOn: preset,
					fields: fields,
					id: id,
					onGrab: true
				),
				forceSave: true
			)
		)
		#expect(updated.name == "Integration Test Notification Renamed")
		#expect(updated.onGrab == true)

		try await client.request(.deleteNotification(id: id))

		let remaining = try await client.request(.notifications)
		#expect(!remaining.contains(where: { $0.id == id }))
	}

	@Test
	func test_notificationSchema() async throws {
		let schema = try await client.request(.notificationSchema)

		#expect(!schema.isEmpty)
	}

	@Test
	func test_testAllNotifications() async throws {
		try await client.request(.testAllNotifications)
	}
}
