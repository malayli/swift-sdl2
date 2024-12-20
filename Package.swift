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
        .systemLibrary(
            name: "CSDL2_ttf",
            pkgConfig: "sdl2_ttf",
            providers: [
                .brew(["sdl2_ttf"])
            ]
        ),
        .executableTarget(
            name: "MyGame",
            dependencies: ["CSDL2", "CSDL2_ttf"],
            resources: [
                .process("Resources")  // Changé de .copy à .process
            ],
            linkerSettings: [
                .linkedLibrary("SDL2"),
                .linkedLibrary("SDL2_ttf")
            ]
        )
    ]
)