// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AiPlayerLib",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AiPlayerLib",
            targets: ["AiPlayerLib"]),
    ],
    dependencies: [
        .package(name: "Model", path: "../Model")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AiPlayerLib",
            dependencies: ["Model"]),
        .testTarget(
            name: "AiPlayerLibTests",
            dependencies: ["AiPlayerLib"]),
    ]
)
