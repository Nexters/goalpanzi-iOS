import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Domain.name+ModulePath.Domain.Player.rawValue,
    targets: [    
        .domain(
            interface: .Player,
            factory: .init()
        ),
        .domain(
            implements: .Player,
            factory: .init(
                dependencies: [
                    .domain(interface: .Player)
                ]
            )
        ),
    
        .domain(
            testing: .Player,
            factory: .init(
                dependencies: [
                    .domain(interface: .Player)
                ]
            )
        ),
        .domain(
            tests: .Player,
            factory: .init(
                dependencies: [
                    .domain(testing: .Player)
                ]
            )
        ),

    ]
)
