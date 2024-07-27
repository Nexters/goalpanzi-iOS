import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Data.name+ModulePath.Data.Remote.rawValue,
    targets: [    
        .data(
            interface: .Remote,
            factory: .init()
        ),
        .data(
            implements: .Remote,
            factory: .init(
                dependencies: [
                    .data(interface: .Remote),
                    .domain,
                ]
            )
        ),
    
        .data(
            testing: .Remote,
            factory: .init(
                dependencies: [
                    .data(interface: .Remote)
                ]
            )
        ),
        .data(
            tests: .Remote,
            factory: .init(
                dependencies: [
                    .data(testing: .Remote)
                ]
            )
        ),

    ]
)
