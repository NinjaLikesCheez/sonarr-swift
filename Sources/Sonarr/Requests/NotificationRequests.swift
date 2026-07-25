import APIClient
import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public extension SonarrRequest where SonarrResponse == [NotificationResource] {
	/// Gets all configured notifications.
	///
	/// Endpoint: `GET /api/v3/notification`
	///
	/// Result: the saved notifications.
	static var notifications: SonarrRequest<[NotificationResource]> {
		SonarrRequest(method: .get, path: "api/v3/notification")
	}

	/// Gets the available notification implementations and their configurable fields.
	///
	/// Endpoint: `GET /api/v3/notification/schema`
	///
	/// Result: the implementation templates that can be used to add a notification.
	static var notificationSchema: SonarrRequest<[NotificationResource]> {
		SonarrRequest(method: .get, path: "api/v3/notification/schema")
	}
}

public extension SonarrRequest where SonarrResponse == NotificationResource {
	/// Gets a single notification.
	///
	/// Endpoint: `GET /api/v3/notification/{id}`
	///
	/// Result: the requested notification.
	///
	/// - Parameter id: The unique identifier of the notification.
	static func notification(id: Int) -> SonarrRequest<NotificationResource> {
		SonarrRequest(method: .get, path: "api/v3/notification/\(id)")
	}

	/// Creates a new notification.
	///
	/// Endpoint: `POST /api/v3/notification`
	///
	/// Result: the created notification.
	///
	/// - Parameters:
	///   - notification: The notification to create.
	///   - forceSave: Whether to save the notification even if Sonarr can't validate it.
	static func addNotification(
		_ notification: NotificationResource,
		forceSave: Bool = false
	) -> SonarrRequest<NotificationResource> {
		SonarrRequest(
			method: .post,
			path: "api/v3/notification",
			queryItems: [URLQueryItem(name: "forceSave", value: String(forceSave))],
			body: { JSONBody(notification) }
		)
	}

	/// Updates an existing notification.
	///
	/// Endpoint: `PUT /api/v3/notification/{id}`
	///
	/// Result: the updated notification.
	///
	/// - Parameters:
	///   - id: The unique identifier of the notification to update.
	///   - notification: The new notification.
	///   - forceSave: Whether to save the notification even if Sonarr can't validate it.
	static func updateNotification(
		id: Int,
		_ notification: NotificationResource,
		forceSave: Bool = false
	) -> SonarrRequest<NotificationResource> {
		SonarrRequest(
			method: .put,
			path: "api/v3/notification/\(id)",
			queryItems: [URLQueryItem(name: "forceSave", value: String(forceSave))],
			body: { JSONBody(notification) }
		)
	}
}

public extension SonarrRequest where SonarrResponse == EmptyResponse {
	/// Deletes a notification.
	///
	/// Endpoint: `DELETE /api/v3/notification/{id}`
	///
	/// - Parameter id: The unique identifier of the notification to delete.
	static func deleteNotification(id: Int) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .delete, path: "api/v3/notification/\(id)")
	}

	/// Tests the configuration for a notification without saving it.
	///
	/// Endpoint: `POST /api/v3/notification/test`
	///
	/// - Parameters:
	///   - notification: The notification configuration to test.
	///   - forceTest: Whether to run the test even if Sonarr would normally skip it.
	static func testNotification(
		_ notification: NotificationResource,
		forceTest: Bool = false
	) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(
			method: .post,
			path: "api/v3/notification/test",
			queryItems: [URLQueryItem(name: "forceTest", value: String(forceTest))],
			body: { JSONBody(notification) }
		)
	}

	/// Tests the configuration for all configured notifications.
	///
	/// Endpoint: `POST /api/v3/notification/testall`
	static var testAllNotifications: SonarrRequest<EmptyResponse> {
		SonarrRequest(method: .post, path: "api/v3/notification/testall")
	}

	/// Performs an implementation-defined action for a notification (e.g. a "check for updates" button).
	///
	/// Endpoint: `POST /api/v3/notification/action/{name}`
	///
	/// - Parameters:
	///   - name: The name of the action to perform.
	///   - notification: The notification configuration the action is performed against.
	static func performNotificationAction(
		name: String,
		_ notification: NotificationResource
	) -> SonarrRequest<EmptyResponse> {
		SonarrRequest(
			method: .post,
			path: "api/v3/notification/action/\(name)",
			body: { JSONBody(notification) }
		)
	}
}
