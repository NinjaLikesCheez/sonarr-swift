public extension SonarrRequest where SonarrResponse == [DiskSpaceResource] {
	/// Gets the free and total space for each disk or mount point known to Sonarr.
	///
	/// Endpoint: `GET /api/v3/diskspace`
	///
	/// Result: the disk space entries reported by the server.
	static var diskSpace: SonarrRequest<[DiskSpaceResource]> {
		SonarrRequest(method: .get, path: "api/v3/diskspace")
	}
}
