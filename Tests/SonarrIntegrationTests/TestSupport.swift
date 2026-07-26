import Foundation

/// Retries `operation` until `condition` is satisfied or a fixed number of attempts is exhausted,
/// returning the last result either way.
///
/// Several of Sonarr's bulk/editor endpoints (series, download clients, episode files) apply their
/// changes via an async command, so a read immediately after the write isn't guaranteed to reflect it -
/// use this instead of asserting on the very next read.
func poll<T>(
	attempts: Int = 40,
	delayNanoseconds: UInt64 = 500_000_000,
	_ operation: () async throws -> T,
	until condition: (T) -> Bool
) async throws -> T {
	var result = try await operation()
	for _ in 1..<attempts where !condition(result) {
		try await Task.sleep(nanoseconds: delayNanoseconds)
		result = try await operation()
	}
	return result
}
