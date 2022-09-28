// swift-tools-version:5.6
import PackageDescription
import Foundation

let package = Package(
    name: "BrightDay",
    platforms: [
       .macOS(.v12)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(
            url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        
        // 🍃 Leaf templating language.
        .package(
            url: "https://github.com/vapor/leaf.git", from: "4.0.0"),
        
        // SendGrid Mailing
        .package(
            url: "https://github.com/vapor-community/sendgrid.git", from: "4.0.0")
        
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Leaf", package: "leaf"),
                .product(name: "SendGrid", package: "sendgrid")
            ],
            swiftSettings: [
                // Enable better optimizations when building in Release configuration. Despite the use of
                // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
                // builds. See <https://github.com/swift-server/guides/blob/main/docs/building.md#building-for-production> for details.
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]
        ),
        .executableTarget(name: "Run", dependencies: [.target(name: "App")]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
