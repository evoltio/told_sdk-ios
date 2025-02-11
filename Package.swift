// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "Told",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "ToldLib",
            targets: ["Told"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apollographql/apollo-ios.git", from: "1.3.3"),
    ],
    targets: [
        .target(
            name: "Told",
            dependencies: [
                .product(name: "Apollo", package: "apollo-ios")
            ],
            path: "Sources",
            exclude: ["Remote/graphql"],
            sources: [
                "Told",
                "Remote",
                "Local",
                "Models",
                "UI"
            ],
            swiftSettings: [
                .unsafeFlags(["-enable-bare-slash-regex"])
            ]
        )
    ]
)
