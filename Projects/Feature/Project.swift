import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let targets: [Target] = [
    .feature(
        factory: .init(
            dependencies: [
                .feature(implements: .Login),
                .feature(implements: .PieceCreation),
                .feature(implements: .Entrance),
                .feature(implements: .Setting),
                .domain,
            ]
        )
    )
]

let project: Project = .makeModule(
    name: "Feature",
    targets: targets
)

