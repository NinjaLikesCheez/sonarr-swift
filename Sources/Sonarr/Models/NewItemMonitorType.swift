/// Whether newly added items from an import list are monitored.
public enum NewItemMonitorType: String, Equatable, Codable, Sendable {
	/// New items are monitored.
	case all
	/// New items are not monitored.
	case none
}
