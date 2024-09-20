// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "PayablMerchant",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "PayablMerchant",
            targets: ["PayablMerchant"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "PayablMerchant",
            path: "./PayablMerchant.xcframework"
        )
    ]
)
