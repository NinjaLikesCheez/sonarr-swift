/// Whether newly added items from an import list should be monitored.
public enum NewItemMonitorType: String, Equatable, Codable, Sendable {
	/// Monitor all new items.
	case all
	/// Monitor no new items.
	case none
}
