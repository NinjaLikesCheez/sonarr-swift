public extension SonarrRequest where SonarrResponse == [IndexerFlagResource] {
	/// Gets the flags that indexers can attach to releases.
	///
	/// Endpoint: `GET /api/v3/indexerflag`
	///
	/// Result: the indexer flags known to the server.
	static var indexerFlags: SonarrRequest<[IndexerFlagResource]> {
		SonarrRequest(method: .get, path: "api/v3/indexerflag")
	}
}
