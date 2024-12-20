// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "MyGame",
    platforms: [
        .macOS(.v11)
    ],
    targets: [
        .systemLibrary(
            name: "CSDL2",
            pkgConfig: "sdl2",
            providers: [
                .brew(["sdl2"])
            ]
        ),
        .executableTarget(
            name: "MyGame",
            dependencies: ["CSDL2"]
        )
    ]
)
