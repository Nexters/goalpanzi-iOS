import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Domain.name+ModulePath.Domain.Competition.rawValue,
    targets: [    
        .domain(
            interface: .Competition,
            factory: .init(
                dependencies: [
                    .domain(interface: .Board),
                    .domain(interface: .Player)
                ]
            )
        ),
        .domain(
            implements: .Competition,
            factory: .init(
                dependencies: [
                    .domain(interface: .Competition)
                ]
            )
        ),
    
        .domain(
            testing: .Competition,
            factory: .init(
                dependencies: [
                    .domain(interface: .Competition)
                ]
            )
        ),
        .domain(
            tests: .Competition,
            factory: .init(
                dependencies: [
                    .domain(testing: .Competition)
                ]
            )
        ),

    ]
)
