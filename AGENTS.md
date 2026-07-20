# AGENTS.md

This file provides guidance to Claude Code (claude.ai/code) and other coding agents when working with code in this repository. `CLAUDE.md` is a symlink to this file.

## What this is

A Swift Concurrency-powered Sonarr v3 REST API client (Swift package, `swift-tools-version:6.0`). It builds on top of the [swift-api-client](https://github.com/NinjaLikesCheez/swift-api-client) package (`APIClient` module), which provides the generic `Client`/`Request` protocol machinery, and follows the same design as [Deluge-Swift](https://github.com/NinjaLikesCheez/Deluge-Swift). This repo layers Sonarr-specific request types, models, and error handling on top of that.

Endpoint coverage is tracked as GitHub issues, one per Sonarr API group (tag in Sonarr's OpenAPI spec, vendored at [specs/v3.json](specs/v3.json)). When implementing one, check the spec for the exact request/response shapes, then follow the conventions below and add tests alongside the endpoints.

## Commands

- Build: `swift build`
- Format (in place): `scripts/format.sh`
- Lint (check only): `scripts/lint.sh` — use `scripts/lint.sh --strict` to match CI
- Full CI sequence locally: `scripts/run_ci.sh` (requires a clean git tree; fails if `scripts/format.sh` produces changes, then lints strictly, then does a clean `swift build`)
- Run tests: `swift test`
- Run a single test: `swift test --filter <SuiteName>/<testMethodName>`

Formatting/linting uses `xcrun swift-format` with the config in `.swift-format` (tabs, 120 col line length, enforced import ordering). CI (`.github/workflows/ci.yml`) runs on `macos-15` via `scripts/run_ci.sh` and will fail if code isn't pre-formatted; `.github/workflows/test.yml` runs `swift test` on Linux.

## Architecture

### OpenAPI spec

[specs/v3.json](specs/v3.json) is a vendored copy of Sonarr's v3 OpenAPI spec (`src/Sonarr.Api.V3/openapi.json` in the [Sonarr/Sonarr](https://github.com/Sonarr/Sonarr) repo, `develop` branch), pretty-printed for readability. It's the source of truth for exact request/response shapes, field names, and enum values when implementing an endpoint — check it before guessing at a model's fields. It's a point-in-time snapshot, not auto-updated, so re-fetch it from upstream if it looks stale relative to the Sonarr version being targeted.

### Request/Response flow

- `Sonarr` ([Sources/Sonarr/Core/Sonarr.swift](Sources/Sonarr/Core/Sonarr.swift)) is the main client, conforming to `Client` from `APIClient`. It holds the `baseURL`, the `apiKey` (sent as the `X-Api-Key` default header), optional basic auth, a `JSONDecoder` configured for Sonarr's ISO 8601 dates (with and without fractional seconds), and a shared `validate` closure.
- Every endpoint call is expressed as a `SonarrRequest<Response>` ([Sources/Sonarr/Core/SonarrRequest.swift](Sources/Sonarr/Core/SonarrRequest.swift)), constructed with an `HTTPMethod`, a path relative to the server root (e.g. `api/v3/series` — the `api/v3` prefix is part of the path, since some endpoints live outside it, e.g. `feed/v3/calendar/sonarr.ics`), optional `URLQueryItem`s, and an optional body/transform.
- Concrete requests live under `Sources/Sonarr/Requests/` as static factory methods/properties on `SonarrRequest`, grouped by OpenAPI tag (e.g. `SeriesRequests.swift`, `EpisodeRequests.swift`). When adding a new endpoint, follow this pattern: add a static factory in the relevant `*Requests.swift` file rather than constructing `SonarrRequest` inline at call sites.
- Unlike Deluge's JSON-RPC (which always returns HTTP 200), Sonarr is a plain REST API with meaningful status codes. `Sonarr.validate(data:response:)` translates non-2xx status codes into typed `SonarrResponseError` cases, decoding Sonarr's error envelope (`Sonarr.ErrorResponse`, `{"message": ..., "description": ...}`) for the message and the field-level `[ValidationFailure]` array shape for HTTP 400.
- Endpoints whose responses are empty (most `DELETE`s and command-style `POST`s) should use the `SonarrRequest<EmptyResponse>` convenience initializer, which skips response decoding entirely — an empty body would fail the default JSON decode.

### Error model

`Sonarr.Error` (the client's associated `Error` type) is `APIClient.ClientError<SonarrResponseError>`. `SonarrResponseError` ([Sources/Sonarr/Core/SonarrError.swift](Sources/Sonarr/Core/SonarrError.swift)) models the HTTP-level failures: `.unauthorized` (401 — bad/missing API key), `.notFound`, `.validation([ValidationFailure])` (400 with field-level failures), and `.statusCode(_:message:)` for everything else.

### Models

`Sources/Sonarr/Models/` contains `Decodable` types returned by requests — check here before adding a new model type in case an existing one already fits. Sonarr's wire format is camelCase, matching Swift property names, so models generally don't need `CodingKeys`.

### Platform support

Cross-platform (iOS 18+, tvOS 18+, macOS 15+, and Linux via SwiftPM): guards around `canImport(FoundationNetworking)` exist because `URLSession` availability differs on Linux — preserve this guard when touching `Sonarr.swift`.

### Tests

- `Tests/SonarrTests/` holds unit-style tests that don't need a live server (`validate` mapping, request construction, date decoding). An integration test target hitting a real Sonarr instance (e.g. `linuxserver/sonarr` in Docker) should follow Deluge-Swift's `DelugeIntegrationTests` pattern (shared client, `.serialized` suites, fixtures centralized in a `TestConfig.swift`) when endpoint work starts.

## Style & Conventions

Formatting itself (indentation, line length, import order) is enforced mechanically by `scripts/format.sh`/`scripts/lint.sh` — don't hand-format, just run the script. The conventions below are things the tooling won't catch.

### Doc comments

- Every public type, property, and function gets a one-line `///` summary above it. For request factories, follow the shape used in Deluge-Swift, adapted to REST:
  ```swift
  /// <What it does, one sentence.>
  ///
  /// Endpoint: `GET /api/v3/series`
  ///
  /// Result: <what the response value represents> (omit this line if the response is `EmptyResponse` and self-explanatory)
  ///
  /// - Parameter(s): <standard swift-doc parameter block>
  static func foo(...) -> SonarrRequest<...> { ... }
  ```
- Model properties each get their own `///` line directly above the property, not a block comment above the whole type.
- Non-obvious behavior (server quirks, pagination semantics, ordering constraints) gets explained in a regular `//` comment at the point of the workaround, with enough context to stand alone. Don't write comments that just restate what the code does.

### Naming & API shape

- Request factories read as a fluent sentence at the call site: `client.request(.series)`, `.episodes(seriesID:)`, `.deleteSeries(id:)`. Prefer overloaded static funcs distinguished by argument label over inventing distinct verbs per variant.
- Static factories with no arguments are computed `var`s (e.g. `health`, `diskSpace`), not `func()`.
- Model properties use Swift naming; Sonarr's camelCase wire format usually matches directly, so only add a `CodingKey` enum when the wire name genuinely differs.
- Prefer `Equatable, Decodable, Sendable` conformances on model structs as a matter of course.

### Error handling

- Don't introduce new untyped `throws` where a typed error already models the failure — this codebase uses typed throws (`throws(Sonarr.Error)`) at the public API boundary in `Sonarr.swift`. Match that when extending client-level entry points.
- Model errors as enum cases with associated data rather than stringly-typed errors, and give each case a `///` doc comment explaining when it occurs (see `SonarrResponseError`).
- When a Sonarr quirk needs a workaround, encode the detection logic where the error is produced (`Sonarr.validate`) rather than downstream at call sites, and link the upstream bug/ticket in a comment if one exists.

### Requests vs. models

- New endpoints are added as static factories in the relevant `Sources/Sonarr/Requests/*Requests.swift` file (grouped by OpenAPI tag), never constructed inline at the call site.
- Custom response parsing (when the default decode isn't enough) goes in the request's `transform` closure, not as a separate free function or extension.

### Tests

- Tests use **Swift Testing** (`import Testing`, `@Suite`, `@Test`, `#expect`), not XCTest.
- Future integration test suites should be annotated `@Suite("...", .serialized)` and share a single client instance, following Deluge-Swift.
- Write `async throws` tests for each request (e.g. `test_foo()`).
