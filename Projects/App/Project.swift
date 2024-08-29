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
                    "CFBundleDisplayName": "미션메이트",
                    "CFBundleIconName": "AppIcon",
                    "UILaunchStoryboardName": "LaunchScreen",
                    "UIApplicationSceneManifest": [
                        "UIApplicationSupportsMultipleScenes": false,
                        "UISceneConfigurations": []
                    ],
                    "UIUserInterfaceStyle": "Light",
                    "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"]
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
