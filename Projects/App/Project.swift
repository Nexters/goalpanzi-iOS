import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let targets: [Target] = [
    .app(
        implements: .iOS,
        factory: .init(
            infoPlist: .extendingDefault(
                with: [
                    "BASE_URL": "https://mission-mate.kro.kr/",
                    "CFBundleShortVersionString": "1.0",
                    "CFBundleVersion": "1",
                    "CFBundleName": "MissionMate",
                    "CFBundleIconName": "AppIcon",
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                    "UIApplicationSceneManifest": [
                        "UIApplicationSupportsMultipleScenes": false,
                        "UISceneConfigurations": []
                    ],
                    "NSAppTransportSecurity": [
                        "NSAllowsArbitraryLoads": true
                    ]
                ]),
            entitlements: "MissionMate.entitlements",
            dependencies: [
                .feature
            ]
        )
    )
]

let project: Project = .makeModule(
    name: "MissionMate",
    targets: targets
)
