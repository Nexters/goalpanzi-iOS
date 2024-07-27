import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Feature.name+ModulePath.Feature.Login.rawValue,
    targets: [    
        .feature(
            interface: .Login,
            factory: .init(
                dependencies: [
                    .domain
                ]
            )
        ),
        .feature(
            implements: .Login,
            factory: .init(
                dependencies: [
                    .feature(interface: .Login)
                ]
            )
        ),
    
        .feature(
            testing: .Login,
            factory: .init(
                dependencies: [
                    .feature(interface: .Login)
                ]
            )
        ),
        .feature(
            tests: .Login,
            factory: .init(
                dependencies: [
                    .feature(testing: .Login)
                ]
            )
        ),
    
        .feature(
            example: .Login,
            factory: .init(
                bundleId: Project.Environment.bundlePrefix,
                infoPlist: .extendingDefault(
                    with: [
                        "BASE_URL": "http://223.130.130.31:8080/",
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
                    .feature(interface: .Login)
                ]
            )
        )

    ]
)
