// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "atpctrl",
    platforms: [
            .macOS(.v13),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.5.0"),
        .package(url: "https://github.com/MasterJ93/ATProtoKit.git", from: "0.20.0"),
        .package(url: "https://github.com/KC-2001MS/SwiftLI.git", from: "0.3.0"),
        .package(url: "https://github.com/apple/swift-testing.git", branch: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "atpctrl",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "ATProtoKit", package: "ATProtoKit"),
                .product(name: "SwiftLI", package: "SwiftLI")
            ]
        ),
        .testTarget(
            name: "atpctrlTests",
            dependencies: [
                .product(name: "Testing", package: "swift-testing"),
                "atpctrl"
            ],
            resources: [.process("account.json")]
        )
    ]
)
