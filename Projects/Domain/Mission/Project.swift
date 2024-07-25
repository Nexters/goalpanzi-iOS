import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Domain.name+ModulePath.Domain.Mission.rawValue,
    targets: [    
        .domain(
            interface: .Mission,
            factory: .init(
                dependencies: [
                    .domain(interface: .Competition)
                ]
            )
        ),
        .domain(
            implements: .Mission,
            factory: .init(
                dependencies: [
                    .domain(interface: .Mission)
                ]
            )
        ),
    
        .domain(
            testing: .Mission,
            factory: .init(
                dependencies: [
                    .domain(interface: .Mission)
                ]
            )
        ),
        .domain(
            tests: .Mission,
            factory: .init(
                dependencies: [
                    .domain(testing: .Mission)
                ]
            )
        ),

    ]
)
