import Foundation

enum TestConfig {
	static let serverURL = URL(string: "http://localhost:8989")!

	// Sonarr generates this on first launch (stored in config.xml); the integration test script reads it out
	// of the container and passes it through so the client can authenticate.
	static let apiKey = ProcessInfo.processInfo.environment["SONARR_API_KEY"] ?? ""
}
