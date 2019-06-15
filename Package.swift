// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HUEApi",
    platforms: [
        .macOS(.v10_12), .iOS(.v11), .watchOS(.v2), .tvOS(.v9)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "HUEApi",
            targets: ["HUEApi"]),
    ],
    dependencies: [
        .package(url: "https://github.com/JuanjoArreola/Apic.git", from: "5.1.1"),
        .package(url: "https://github.com/JuanjoArreola/Logg.git", from: "2.1.0")
//        .package(url: "../Apic", from: "5.1.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "HUEApi",
            dependencies: ["Apic"]),
        .testTarget(
            name: "HUEApiTests",
            dependencies: ["HUEApi", "Logg"]),
    ]
)
