import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Feature.name+ModulePath.Feature.Setting.rawValue,
    targets: [    
        .feature(
            interface: .Setting,
            factory: .init(
                dependencies: [
                    .domain,
                    .data
                ]
            )
        ),
        .feature(
            implements: .Setting,
            factory: .init(
                dependencies: [
                    .feature(interface: .Setting)
                ]
            )
        ),
    
        .feature(
            testing: .Setting,
            factory: .init(
                dependencies: [
                    .feature(interface: .Setting)
                ]
            )
        ),
        .feature(
            tests: .Setting,
            factory: .init(
                dependencies: [
                    .feature(testing: .Setting)
                ]
            )
        ),
    
        .feature(
            example: .Setting,
            factory: .init(
                bundleId: Project.Environment.bundlePrefix,
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
                dependencies: [
                    .feature(interface: .Setting)
                ]
            )
        )

    ]
)
