// swift-tools-version:6.0
import PackageDescription
import CompilerPluginSupport

let package:Package = .init(
    name: "Swift unified codelink format",
    platforms: [.macOS(.v15), .iOS(.v18), .tvOS(.v18), .visionOS(.v2), .watchOS(.v11)],
    products: [
        .library(name: "help", targets: ["help"]),
        .library(name: "proposals", targets: ["proposals"]),

        .library(name: "FNV1", targets: ["FNV1"]),
        .library(name: "UCF", targets: ["UCF"]),
        .library(name: "URI", targets: ["URI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/tayloraswift/swift-grammar", from: "0.4.0"),
    ],
    targets: [
        .target(name: "help"),
        .target(name: "proposals"),

        .target(name: "FNV1"),

        .target(name: "UCF",
            dependencies: [
                .target(name: "FNV1"),
                .target(name: "URI"),
            ]),

        .target(name: "URI",
            dependencies: [
                .product(name: "Grammar", package: "swift-grammar"),
            ]),


        .testTarget(name: "FNV1Tests",
            dependencies: [
                .target(name: "FNV1"),
            ]),

        .testTarget(name: "UCFTests",
            dependencies: [
                .target(name: "UCF"),
            ]),

        .testTarget(name: "URITests",
            dependencies: [
                .target(name: "URI"),
            ]),
    ])

for target:PackageDescription.Target in package.targets
{
    {
        var settings:[PackageDescription.SwiftSetting] = $0 ?? []

        settings.append(.enableUpcomingFeature("ExistentialAny"))
        settings.append(.enableExperimentalFeature("StrictConcurrency"))

        settings.append(.define("DEBUG", .when(configuration: .debug)))

        $0 = settings
    } (&target.swiftSettings)
}
