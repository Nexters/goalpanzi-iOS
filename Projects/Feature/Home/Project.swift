import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Feature.name+ModulePath.Feature.Home.rawValue,
    targets: [    
        .feature(
            interface: .Home,
            factory: .init(
                dependencies: [
                    .domain,
                    .data,
                    .feature(interface: .Setting),
                ]
            )
        ),
        .feature(
            implements: .Home,
            factory: .init(
                dependencies: [
                    .feature(interface: .Home)
                ]
            )
        ),
    
        .feature(
            testing: .Home,
            factory: .init(
                dependencies: [
                    .feature(interface: .Home)
                ]
            )
        ),
        .feature(
            tests: .Home,
            factory: .init(
                dependencies: [
                    .feature(testing: .Home)
                ]
            )
        ),
    
        .feature(
            example: .Home,
            factory: .init(
                infoPlist: .extendingDefault(
                    with: [
                        "BASE_URL": "https://mission-mate.kro.kr/",
                        "UILaunchStoryboardName": "LaunchScreen.storyboard",
                        "UIApplicationSceneManifest": [
                            "UIApplicationSupportsMultipleScenes": false,
                            "UISceneConfigurations": []
                        ]
                    ]),
                dependencies: [
                    .feature(interface: .Home),
                ]
            )
        )

    ]
)
