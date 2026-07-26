/// A request body for bulk-editing or bulk-deleting multiple series at once.
public struct SeriesEditorResource: Equatable, Encodable, Sendable {
	/// The identifiers of the series to edit or delete.
	public let seriesIds: [Int]?
	/// Whether the series should be monitored.
	public let monitored: Bool?
	/// Whether newly added seasons/episodes are monitored.
	public let monitorNewItems: NewItemMonitorType?
	/// The identifier of the quality profile to apply.
	public let qualityProfileId: Int?
	/// The scheduling type to apply.
	public let seriesType: SeriesType?
	/// Whether each season should have its own subfolder under the series folder.
	public let seasonFolder: Bool?
	/// The root folder to move the series under.
	public let rootFolderPath: String?
	/// The tags to apply, combined with each series' existing tags according to `applyTags`.
	public let tags: [Int]?
	/// How `tags` should be combined with each series' existing tags.
	public let applyTags: ApplyTags?
	/// Whether to move the series' files to their new path, if the path changed.
	public let moveFiles: Bool?
	/// Whether to also delete the series' files from disk. Only used by the delete endpoint.
	public let deleteFiles: Bool?
	/// Whether to prevent deleted series from being re-added by an import list. Only used by the delete endpoint.
	public let addImportListExclusion: Bool?

	/// Creates a series editor request to send to the server.
	/// - Parameters:
	///   - seriesIds: The identifiers of the series to edit or delete.
	///   - monitored: Whether the series should be monitored.
	///   - monitorNewItems: Whether newly added seasons/episodes are monitored.
	///   - qualityProfileId: The identifier of the quality profile to apply.
	///   - seriesType: The scheduling type to apply.
	///   - seasonFolder: Whether each season should have its own subfolder under the series folder.
	///   - rootFolderPath: The root folder to move the series under.
	///   - tags: The tags to apply, combined with each series' existing tags according to `applyTags`.
	///   - applyTags: How `tags` should be combined with each series' existing tags.
	///   - moveFiles: Whether to move the series' files to their new path, if the path changed.
	///   - deleteFiles: Whether to also delete the series' files from disk. Only used by the delete endpoint.
	///   - addImportListExclusion: Whether to prevent deleted series from being re-added by an import list. Only
	///   used by the delete endpoint.
	public init(
		seriesIds: [Int]? = nil,
		monitored: Bool? = nil,
		monitorNewItems: NewItemMonitorType? = nil,
		qualityProfileId: Int? = nil,
		seriesType: SeriesType? = nil,
		seasonFolder: Bool? = nil,
		rootFolderPath: String? = nil,
		tags: [Int]? = nil,
		applyTags: ApplyTags? = nil,
		moveFiles: Bool? = nil,
		deleteFiles: Bool? = nil,
		addImportListExclusion: Bool? = nil
	) {
		self.seriesIds = seriesIds
		self.monitored = monitored
		self.monitorNewItems = monitorNewItems
		self.qualityProfileId = qualityProfileId
		self.seriesType = seriesType
		self.seasonFolder = seasonFolder
		self.rootFolderPath = rootFolderPath
		self.tags = tags
		self.applyTags = applyTags
		self.moveFiles = moveFiles
		self.deleteFiles = deleteFiles
		self.addImportListExclusion = addImportListExclusion
	}
}
