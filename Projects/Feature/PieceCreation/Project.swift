import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Feature.name+ModulePath.Feature.PieceCreation.rawValue,
    targets: [
        .feature(
            interface: .PieceCreation,
            factory: .init(
                dependencies: [
                    .domain
                ]
            )
        ),
        .feature(
            implements: .PieceCreation,
            factory: .init(
                dependencies: [
                    .feature(interface: .PieceCreation)
                ]
            )
        ),
        
            .feature(
                testing: .PieceCreation,
                factory: .init(
                    dependencies: [
                        .feature(interface: .PieceCreation)
                    ]
                )
            ),
        .feature(
            tests: .PieceCreation,
            factory: .init(
                dependencies: [
                    .feature(testing: .PieceCreation)
                ]
            )
        ),
        
            .feature(
                example: .PieceCreation,
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
                        .feature(interface: .PieceCreation)
                    ]
                )
            )
        
    ]
)
