# Sonarr

A Swift Concurrency powered [Sonarr](https://sonarr.tv) v3 REST API client, built on [swift-api-client](https://github.com/NinjaLikesCheez/swift-api-client) and following the same design as [Deluge-Swift](https://github.com/NinjaLikesCheez/Deluge-Swift).

> [!NOTE]
> This is currently the base client only — endpoint coverage is being added incrementally, tracked in [issues](../../issues), one per Sonarr API group.

## Usage

Create a client with your server URL and API key (Sonarr → Settings → General → Security → API Key). The key is sent as the `X-Api-Key` header on every request.

```swift
import Sonarr

let client = Sonarr(baseURL: URL(string: "http://localhost:8989")!, apiKey: "your-api-key")
let series = try await client.request(.series)
```

## Requests

A `SonarrRequest` describes an endpoint's HTTP method, path, query parameters, body, and (optionally) a transform for the response. Endpoints are exposed as static factories on `SonarrRequest`, so call sites read fluently: `client.request(.series)`.

```swift
extension SonarrRequest<[Series]> {
    /// Fetches all series.
    ///
    /// Endpoint: `GET /api/v3/series`
    static var series: SonarrRequest<[Series]> {
        SonarrRequest(method: .get, path: "api/v3/series")
    }
}
```

Errors surface as typed `Sonarr.Error` values — e.g. `.response(.unauthorized)` for a bad API key, `.response(.validation(failures))` for a rejected request with field-level details.

## Installation

### Swift Package Manager

Add the package to your `Package.swift` dependencies:

```swift
.package(url: "https://github.com/NinjaLikesCheez/sonarr-swift.git", from: "0.0.1")
```

Or in Xcode: **File** > **Add Package Dependencies...**, then enter `https://github.com/NinjaLikesCheez/sonarr-swift.git`.

## License

This library is released under the MIT license. See [LICENSE](LICENSE) for details.
