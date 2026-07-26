import Foundation
import Sonarr
import Testing

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

/// Intercepts every request made through a `URLSession` configured with this protocol registered,
/// returning a canned response instead of touching the network. Lets tests exercise `Client.send(request:)`
/// end to end - URL construction, header assembly, body encoding, response validation, and decoding -
/// without a live server, made possible by `Sonarr.session` being injectable (see `Sonarr.init(session:)`).
final class StubURLProtocol: URLProtocol {
	nonisolated(unsafe) static var handler: (@Sendable (URLRequest) throws -> (HTTPURLResponse, Data))?

	override class func canInit(with request: URLRequest) -> Bool { true }
	override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

	override func startLoading() {
		guard let handler = Self.handler else {
			client?.urlProtocol(self, didFailWithError: URLError(.badServerResponse))
			return
		}

		do {
			let (response, data) = try handler(request)
			client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
			client?.urlProtocol(self, didLoad: data)
			client?.urlProtocolDidFinishLoading(self)
		} catch {
			client?.urlProtocol(self, didFailWithError: error)
		}
	}

	override func stopLoading() {}
}

/// A minimal lock-protected box for capturing a value from `StubURLProtocol`'s `@Sendable` handler,
/// which runs on URLSession's own background queue rather than the calling test's task.
private final class Captured<Value>: @unchecked Sendable {
	private let lock = NSLock()
	private var value: Value?

	func set(_ newValue: Value) {
		lock.lock()
		defer { lock.unlock() }
		value = newValue
	}

	func get() -> Value? {
		lock.lock()
		defer { lock.unlock() }
		return value
	}
}

private func makeStubbedClient(
	baseURL: String = "http://localhost:8989",
	apiKey: String = "test-api-key",
	basicAuthentication: BasicAuthentication? = nil
) -> Sonarr {
	let configuration = URLSessionConfiguration.ephemeral
	configuration.protocolClasses = [StubURLProtocol.self]

	return Sonarr(
		baseURL: URL(string: baseURL)!,
		apiKey: apiKey,
		basicAuthentication: basicAuthentication,
		session: URLSession(configuration: configuration)
	)
}

private func jsonResponse(statusCode: Int, body: String, url: URL) -> (HTTPURLResponse, Data) {
	let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
	return (response, Data(body.utf8))
}

// StubURLProtocol.handler is shared, static, mutable state - serialize so concurrently-run tests
// don't race on which handler is installed when a request comes in.
@Suite("Full request pipeline", .serialized)
struct SonarrPipelineTests {
	@Test func joinsBaseURLAndPath() async throws {
		let client = makeStubbedClient()

		let capturedURL = Captured<URL>()
		StubURLProtocol.handler = { request in
			capturedURL.set(request.url!)
			return jsonResponse(statusCode: 200, body: #"{"status": "OK"}"#, url: request.url!)
		}

		_ = try await client.request(.ping)

		#expect(capturedURL.get()?.absoluteString == "http://localhost:8989/ping")
	}

	@Test func sendsApiKeyAndDefaultHeaders() async throws {
		let client = makeStubbedClient(apiKey: "my-secret-key")

		let capturedHeaders = Captured<[String: String]>()
		StubURLProtocol.handler = { request in
			capturedHeaders.set(request.allHTTPHeaderFields ?? [:])
			return jsonResponse(statusCode: 200, body: #"{"status": "OK"}"#, url: request.url!)
		}

		_ = try await client.request(.ping)

		let headers = try #require(capturedHeaders.get())
		#expect(headers["X-Api-Key"] == "my-secret-key")
		#expect(headers["Accept"] == "application/json")
		#expect(headers["Content-Type"] == "application/json")
	}

	@Test func sendsBasicAuthorizationHeaderWhenConfigured() async throws {
		let client = makeStubbedClient(basicAuthentication: BasicAuthentication(username: "user", password: "pass"))

		let capturedHeaders = Captured<[String: String]>()
		StubURLProtocol.handler = { request in
			capturedHeaders.set(request.allHTTPHeaderFields ?? [:])
			return jsonResponse(statusCode: 200, body: #"{"status": "OK"}"#, url: request.url!)
		}

		_ = try await client.request(.ping)

		let expected = "Basic \(Data("user:pass".utf8).base64EncodedString())"
		#expect(capturedHeaders.get()?["Authorization"] == expected)
	}

	@Test func encodesRequestBodyOntoTheWire() async throws {
		let client = makeStubbedClient()

		let capturedBody = Captured<Data>()
		StubURLProtocol.handler = { request in
			capturedBody.set(request.httpBodyStreamData() ?? request.httpBody ?? Data())
			return jsonResponse(
				statusCode: 200,
				body: #"{"id": 1, "path": "/media", "accessible": true, "freeSpace": 100, "unmappedFolders": []}"#,
				url: request.url!
			)
		}

		_ = try await client.request(.addRootFolder(RootFolderResource(path: "/media")))

		let body = try #require(capturedBody.get())
		let json = try #require(JSONSerialization.jsonObject(with: body) as? [String: Any])
		#expect(json["path"] as? String == "/media")
	}

	@Test func decodesSuccessfulResponseIntoTheExpectedType() async throws {
		let client = makeStubbedClient()

		StubURLProtocol.handler = { request in
			jsonResponse(statusCode: 200, body: #"{"status": "OK"}"#, url: request.url!)
		}

		let ping = try await client.request(.ping)

		#expect(ping.status == "OK")
	}

	@Test func routesNonSuccessStatusCodeThroughValidate() async throws {
		let client = makeStubbedClient()

		StubURLProtocol.handler = { request in
			jsonResponse(statusCode: 401, body: "", url: request.url!)
		}

		do {
			_ = try await client.request(.ping)
			Issue.record("Expected the request to throw")
		} catch let error as Sonarr.Error {
			guard case .response(.unauthorized) = error else {
				Issue.record("Expected .response(.unauthorized), got \(error)")
				return
			}
		}
	}

	@Test func mapsTransportFailuresToRequestURLError() async throws {
		let client = makeStubbedClient()

		StubURLProtocol.handler = { _ in
			throw URLError(.notConnectedToInternet)
		}

		do {
			_ = try await client.request(.ping)
			Issue.record("Expected the request to throw")
		} catch let error as Sonarr.Error {
			guard case .request(.urlError(let urlError)) = error else {
				Issue.record("Expected .request(.urlError), got \(error)")
				return
			}
			#expect(urlError.code == .notConnectedToInternet)
		}
	}

	@Test func usesCustomTransformInsteadOfDefaultDecodeWhenPresent() async throws {
		let client = makeStubbedClient()

		StubURLProtocol.handler = { request in
			jsonResponse(statusCode: 200, body: "", url: request.url!)
		}

		// deleteRootFolder is EmptyResponse-typed, so its transform ignores the (empty) body entirely -
		// exercising the request/transform path rather than the default JSONDecoder path.
		try await client.request(.deleteRootFolder(id: 1))
	}
}

extension URLRequest {
	fileprivate func httpBodyStreamData() -> Data? {
		guard let stream = httpBodyStream else { return nil }
		stream.open()
		defer { stream.close() }

		var data = Data()
		let bufferSize = 4096
		var buffer = [UInt8](repeating: 0, count: bufferSize)

		while stream.hasBytesAvailable {
			let read = stream.read(&buffer, maxLength: bufferSize)
			if read <= 0 { break }
			data.append(buffer, count: read)
		}

		return data.isEmpty ? nil : data
	}
}
