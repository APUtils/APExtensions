// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "APExtensions",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_13),
        .tvOS(.v11),
        .watchOS(.v4),
    ],
    products: [
        .library(
            name: "APExtensions",
            targets: ["APExtensions"]
        ),
        .library(
            name: "APExtensionsCore",
            targets: ["APExtensionsCore"]
        ),
        .library(
            name: "APExtensionsViewModel",
            targets: ["APExtensionsViewModel"]
        ),
        .library(
            name: "APExtensionsStoryboard",
            targets: ["APExtensionsStoryboard"]
        ),
        .library(
            name: "APExtensionsOccupiable",
            targets: ["APExtensionsOccupiable"]
        ),
        .library(
            name: "APExtensionsOptionalType",
            targets: ["APExtensionsOptionalType"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/APUtils/LogsManager.git", .upToNextMajor(from: "12.0.0")),
    ],
    targets: [
        .target(
            name: "APExtensions",
            dependencies: [
                "APExtensionsCore",
                "APExtensionsViewModel",
                "APExtensionsStoryboard",
            ],
            path: "APExtensions/Classes/APExtensions"
        ),
        .target(
            name: "APExtensionsCore",
            dependencies: [
                .product(name: "RoutableLogger", package: "LogsManager"),
                "APExtensionsShared",
                "APExtensionsOccupiable",
                "APExtensionsOptionalType",
            ],
            path: "APExtensions/Classes/Core",
            exclude: ["_Protocols/Occupiable", "_Protocols/OptionalType"],
            swiftSettings: [
                .define("SPM"),
            ]
        ),
        .target(
            name: "APExtensionsViewModel",
            dependencies: [],
            path: "APExtensions/Classes/ViewModel/",
            swiftSettings: [
                .define("SPM"),
            ]
        ),
        .target(
            name: "APExtensionsStoryboard",
            dependencies: [
                .product(name: "RoutableLogger", package: "LogsManager"),
                "APExtensionsShared",
            ],
            path: "APExtensions/Classes/Storyboard",
            swiftSettings: [
                .define("SPM"),
            ]
        ),
        .target(
            name: "APExtensionsShared",
            dependencies: [],
            path: "APExtensions/Classes/Shared",
            swiftSettings: [
                .define("SPM"),
            ]
        ),
        .target(
            name: "APExtensionsOccupiable",
            dependencies: [],
            path: "APExtensions/Classes/Core/_Protocols/Occupiable",
            swiftSettings: [
                .define("SPM"),
            ]
        ),
        .target(
            name: "APExtensionsOptionalType",
            dependencies: [],
            path: "APExtensions/Classes/Core/_Protocols/OptionalType",
            swiftSettings: [
                .define("SPM"),
            ]
        ),
    ]
)
