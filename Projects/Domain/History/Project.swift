import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Domain.name+ModulePath.Domain.History.rawValue,
    targets: [    
        .domain(
            interface: .History,
            factory: .init(dependencies: [
                .shared,
                .domain(interface: .User)
            ])
        ),
        .domain(
            implements: .History,
            factory: .init(
                dependencies: [
                    .domain(interface: .History)
                ]
            )
        ),
    
        .domain(
            testing: .History,
            factory: .init(
                dependencies: [
                    .domain(interface: .History)
                ]
            )
        ),
        .domain(
            tests: .History,
            factory: .init(
                dependencies: [
                    .domain(testing: .History)
                ]
            )
        ),

    ]
)
