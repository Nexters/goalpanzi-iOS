import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Feature.name+ModulePath.Feature.Entrance.rawValue,
    targets: [    
        .feature(
            interface: .Entrance,
            factory: .init(
                dependencies: [
                    .domain,
                    .data,
                    .feature(interface: .Setting),
                ]
            )
        ),
        .feature(
            implements: .Entrance,
            factory: .init(
                dependencies: [
                    .feature(interface: .Entrance)
                ]
            )
        ),
    
        .feature(
            testing: .Entrance,
            factory: .init(
                dependencies: [
                    .feature(interface: .Entrance)
                ]
            )
        ),
        .feature(
            tests: .Entrance,
            factory: .init(
                dependencies: [
                    .feature(testing: .Entrance)
                ]
            )
        ),
    
        .feature(
            example: .Entrance,
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
                    .feature(interface: .Entrance)
                ]
            )
        )

    ]
)
