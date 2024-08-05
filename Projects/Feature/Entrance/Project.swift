import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Feature.name+ModulePath.Feature.Entrance.rawValue,
    targets: [    
        .feature(
            interface: .Entrance,
            factory: .init(
                dependencies: [
                    .domain,
                ]
            )
        ),
        .feature(
            implements: .Entrance,
            factory: .init(
                dependencies: [
                    .feature(interface: .Entrance)
                ]
            )
        ),
    
        .feature(
            testing: .Entrance,
            factory: .init(
                dependencies: [
                    .feature(interface: .Entrance)
                ]
            )
        ),
        .feature(
            tests: .Entrance,
            factory: .init(
                dependencies: [
                    .feature(testing: .Entrance)
                ]
            )
        ),
    
        .feature(
            example: .Entrance,
            factory: .init(
                dependencies: [
                    .feature(interface: .Entrance)
                ]
            )
        )

    ]
)
