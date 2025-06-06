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
                    "CFBundleShortVersionString": "1.2",
                    "CFBundleVersion": "1",
                    "CFBundleName": "MissionMate",
                    "CFBundleDisplayName": "미션메이트",
                    "CFBundleIconName": "AppIcon",
                    "UILaunchStoryboardName": "Launch Screen",
                    "UIApplicationSceneManifest": [
                        "UIApplicationSupportsMultipleScenes": false,
                        "UISceneConfigurations": []
                    ],
                    "UIUserInterfaceStyle": "Light",
                    "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
                    "ITSAppUsesNonExemptEncryption": false
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
