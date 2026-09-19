// swift-tools-version: 5.9
import PackageDescription
import AppleProductTypes

let package = Package(
    name: "FocusSocial",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "FocusSocial",
            targets: ["AppModule"],
            bundleIdentifier: "com.focus.FocusSocial",
            teamIdentifier: "",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .star),
            accentColor: .presetColor(.blue),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: "."
        )
    ]
)