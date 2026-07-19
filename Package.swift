// swift-tools-version:6.0

import PackageDescription

let package = Package(
	name: "Sonarr",
	platforms: [
		.iOS(.v18),
		.tvOS(.v18),
		.macOS(.v15),
	],
	products: [
		.library(name: "Sonarr", targets: ["Sonarr"])
	],
	dependencies: [
		.package(url: "https://github.com/NinjaLikesCheez/swift-api-client", from: "0.0.1")
		// .package(path: "../swift-api-client"),
	],
	targets: [
		.target(
			name: "Sonarr",
			dependencies: [
				.product(name: "APIClient", package: "swift-api-client")
			]
		),
		.testTarget(name: "SonarrTests", dependencies: [.target(name: "Sonarr")]),
	]
)
