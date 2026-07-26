import APIClient
import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public extension SonarrRequest where SonarrResponse == SystemResource {
	/// Gets information about the running Sonarr instance and its environment.
	///
	/// Endpoint: `GET /api/v3/system/status`
	///
	/// Result: the system status.
	static var systemStatus: SonarrRequest<SystemResource> {
		SonarrRequest(method: .get, path: "api/v3/system/status")
	}
}

public extension SonarrRequest where SonarrResponse == String {
	/// Gets a diagnostic dump of Sonarr's internal routing table.
	///
	/// Endpoint: `GET /api/v3/system/routes`
	///
	/// Result: the raw route graph, as plain text.
	static var systemRoutes: SonarrRequest<String> {
		SonarrRequest(
			method: .get,
			path: "api/v3/system/routes",
			transform: { data, _ in String(decoding: data, as: UTF8.self) }
		)
	}
}

public extension SonarrRequest where SonarrResponse == [String: [String]] {
	/// Gets any ambiguous or duplicate routes registered in Sonarr's routing table.
	///
	/// Endpoint: `GET /api/v3/system/routes/duplicate`
	///
	/// Result: a map of route labels to the endpoint names registered against them; empty when
	/// there are no duplicates.
	static var systemDuplicateRoutes: SonarrRequest<[String: [String]]> {
		SonarrRequest(method: .get, path: "api/v3/system/routes/duplicate")
	}
}

public extension SonarrRequest where SonarrResponse == SystemShutdownResource {
	/// Shuts down the Sonarr instance.
	///
	/// Endpoint: `POST /api/v3/system/shutdown`
	///
	/// Result: confirmation that Sonarr has begun shutting down.
	static var shutdownSystem: SonarrRequest<SystemShutdownResource> {
		SonarrRequest(method: .post, path: "api/v3/system/shutdown")
	}
}

public extension SonarrRequest where SonarrResponse == SystemRestartResource {
	/// Restarts the Sonarr instance.
	///
	/// Endpoint: `POST /api/v3/system/restart`
	///
	/// Result: confirmation that Sonarr has begun restarting.
	static var restartSystem: SonarrRequest<SystemRestartResource> {
		SonarrRequest(method: .post, path: "api/v3/system/restart")
	}
}
