// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Payabl",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "Payabl",
            targets: ["PayablMerchantWrapper"])
    ],
    dependencies: [
        .package(url: "https://github.com/bugsnag/bugsnag-cocoa", from: "6.0.0")
    ],
    targets: [
        .binaryTarget(
            name: "PayablMerchant",
            path: "PayablMerchant.xcframework"
        ),
        .target(
            name: "PayablMerchantWrapper",
            dependencies: [
                .product(name: "Bugsnag", package: "bugsnag-cocoa", condition: .when(platforms: [.iOS])),
                .target(name: "PayablMerchant")
            ],
            path: "Sources/PayablMerchantWrapper",
            publicHeadersPath: ""
        )
    ]
)