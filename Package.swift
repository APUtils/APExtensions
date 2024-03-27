// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "APExtensions",
    platforms: [
        .iOS(.v12),
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
        .package(url: "https://github.com/anton-plebanovich/RoutableLogger.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "APExtensions",
            dependencies: [
                "APExtensionsCore",
                "APExtensionsViewModel",
                "APExtensionsStoryboard",
            ],
            path: "APExtensions",
            exclude: [],
            sources: ["Classes/APExtensions"],
            resources: []
        ),
        .target(
            name: "APExtensionsCore",
            dependencies: [
                .product(name: "RoutableLogger", package: "RoutableLogger"),
                "APExtensionsShared",
                "APExtensionsOccupiable",
                "APExtensionsOptionalType",
            ],
            path: "APExtensions",
            exclude: ["Classes/Core/_Protocols/Occupiable", "Classes/Core/_Protocols/OptionalType"],
            sources: ["Classes/Core"],
            resources: [
                .process("Privacy/APExtensions.Core/PrivacyInfo.xcprivacy"),
            ],
            swiftSettings: [
                .define("SPM"),
            ]
        ),
        .target(
            name: "APExtensionsViewModel",
            dependencies: [],
            path: "APExtensions",
            exclude: [],
            sources: ["Classes/ViewModel"],
            resources: [
                .process("Privacy/APExtensions.ViewModel/PrivacyInfo.xcprivacy"),
            ],
            swiftSettings: [
                .define("SPM"),
            ]
        ),
        .target(
            name: "APExtensionsStoryboard",
            dependencies: [
                .product(name: "RoutableLogger", package: "RoutableLogger"),
                "APExtensionsShared",
            ],
            path: "APExtensions",
            exclude: [],
            sources: ["Classes/Storyboard"],
            resources: [
                .process("Privacy/APExtensions.Storyboard/PrivacyInfo.xcprivacy"),
            ],
            swiftSettings: [
                .define("SPM"),
            ]
        ),
        .target(
            name: "APExtensionsShared",
            dependencies: [],
            path: "APExtensions",
            exclude: [],
            sources: ["Classes/Shared"],
            swiftSettings: [
                .define("SPM"),
            ]
        ),
        .target(
            name: "APExtensionsOccupiable",
            dependencies: [],
            path: "APExtensions",
            exclude: [],
            sources: ["Classes/Core/_Protocols/Occupiable"],
            resources: [
                .process("Privacy/APExtensions.Occupiable/PrivacyInfo.xcprivacy"),
            ],
            swiftSettings: [
                .define("SPM"),
            ]
        ),
        .target(
            name: "APExtensionsOptionalType",
            dependencies: [],
            path: "APExtensions",
            exclude: [],
            sources: ["Classes/Core/_Protocols/OptionalType"],
            resources: [
                .process("Privacy/APExtensions.OptionalType/PrivacyInfo.xcprivacy"),
            ],
            swiftSettings: [
                .define("SPM"),
            ]
        ),
    ]
)
