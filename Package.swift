// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "TodoConvert",
    platforms: [.macOS(.v13)],
    products: [
        .library(name: "TodoConvertCore", targets: ["TodoConvertCore"]),
        .executable(name: "TodoConvert", targets: ["TodoConvertApp"]),
        .executable(name: "todoconvert-cli", targets: ["TodoConvertCLI"])
    ],
    dependencies: [
        .package(url: "https://github.com/sparkle-project/Sparkle", exact: "2.10.0")
    ],
    targets: [
        .target(name: "TodoConvertCore", resources: [.copy("Resources")]),
        // The frozen XPC wire protocol stays at its sealed source path. It is compiled
        // into the renamed module without changing its Objective-C identity.
        .target(name: "TodoConvertUpdates", dependencies: [.product(name: "Sparkle", package: "Sparkle")], path: "Sources", exclude: ["TodoConvertApp", "TodoConvertCore", "TodoConvertCLI", "UpdateCredentialBroker"], sources: ["TodoConvertUpdates", "TangerineUpdates/UpdateCredentialBrokerProtocol.swift"]),
        .executableTarget(name: "TodoConvertApp", dependencies: ["TodoConvertCore", "TodoConvertUpdates"], linkerSettings: [.unsafeFlags(["-Xlinker", "-rpath", "-Xlinker", "@executable_path/../Frameworks"])]),
        .executableTarget(name: "TodoConvertCLI", dependencies: ["TodoConvertCore"]),
        .testTarget(name: "TodoConvertCoreTests", dependencies: ["TodoConvertCore"], resources: [.copy("Fixtures")]),
        .testTarget(name: "TodoConvertUpdatesTests", dependencies: ["TodoConvertUpdates"])
    ],
    swiftLanguageModes: [.v5]
)
