// swift-tools-version:6.0
import PackageDescription
import CompilerPluginSupport

let package:Package = .init(
    name: "Swift unified codelink format",
    platforms: [.macOS(.v14)],
    products: [
        .library(name: "grammar", targets: ["grammar"]),
        .library(name: "help", targets: ["help"]),
        .library(name: "proposals", targets: ["proposals"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "grammar", path: "Sources/Grammar"),
        .target(name: "help", path: "Sources/Help"),
        .target(name: "proposals", path: "Sources/Proposals"),
    ])

for target:PackageDescription.Target in package.targets
{
    {
        var settings:[PackageDescription.SwiftSetting] = $0 ?? []

        settings.append(.enableUpcomingFeature("ExistentialAny"))

        settings.append(.define("DEBUG", .when(configuration: .debug)))

        $0 = settings
    } (&target.swiftSettings)
}
