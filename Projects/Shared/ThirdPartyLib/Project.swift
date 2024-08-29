import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Shared.name+ModulePath.Shared.ThirdPartyLib.rawValue,
    targets: [    
        .shared(
            interface: .ThirdPartyLib,
            factory: .init()
        ),
        .shared(
            implements: .ThirdPartyLib,
            factory: .init(
                dependencies: [
                    .shared(interface: .ThirdPartyLib),
                    .external(name: "ComposableArchitecture"),
                    .external(name: "Kingfisher"),
                    .external(name: "Alamofire"),
                    .external(name: "Lottie"),
                ]
            )
        )

    ]
)
