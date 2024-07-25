import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Domain.name+ModulePath.Domain.Board.rawValue,
    targets: [    
        .domain(
            interface: .Board,
            factory: .init()
        ),
        .domain(
            implements: .Board,
            factory: .init(
                dependencies: [
                    .domain(interface: .Board)
                ]
            )
        ),
    
        .domain(
            testing: .Board,
            factory: .init(
                dependencies: [
                    .domain(interface: .Board)
                ]
            )
        ),
        .domain(
            tests: .Board,
            factory: .init(
                dependencies: [
                    .domain(testing: .Board)
                ]
            )
        ),

    ]
)
