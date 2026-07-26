import Sonarr

let client: Sonarr = {
	// Fails fast with a clear message when SONARR_API_KEY isn't set, rather than letting every one of
	// the 100+ integration tests fail independently with a confusing 401.
	precondition(
		!TestConfig.apiKey.isEmpty,
		"SONARR_API_KEY is not set - see scripts/run_integration_tests.sh for how to provide one."
	)

	return Sonarr(baseURL: TestConfig.serverURL, apiKey: TestConfig.apiKey)
}()
