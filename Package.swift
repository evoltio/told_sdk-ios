// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "Told",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "ToldSDK",
            targets: ["Told"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apollographql/apollo-ios.git", from: "1.21.0"),
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
            ]
        )
    ]
)
