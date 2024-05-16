// swift-tools-version:5.10
import PackageDescription
import CompilerPluginSupport

let package:Package = .init(
    name: "Swift unified codelink format",
    platforms: [.macOS(.v14)],
    products: [
        .library(name: "proposals", targets: ["proposals"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "proposals", path: "Sources/Proposals"),
    ])

for target:PackageDescription.Target in package.targets
{
    {
        var settings:[PackageDescription.SwiftSetting] = $0 ?? []

        settings.append(.enableUpcomingFeature("BareSlashRegexLiterals"))
        settings.append(.enableUpcomingFeature("ConciseMagicFile"))
        settings.append(.enableUpcomingFeature("DeprecateApplicationMain"))
        settings.append(.enableUpcomingFeature("ExistentialAny"))
        settings.append(.enableUpcomingFeature("GlobalConcurrency"))
        settings.append(.enableUpcomingFeature("IsolatedDefaultValues"))
        settings.append(.enableExperimentalFeature("StrictConcurrency"))

        settings.append(.define("DEBUG", .when(configuration: .debug)))

        $0 = settings
    } (&target.swiftSettings)
}
