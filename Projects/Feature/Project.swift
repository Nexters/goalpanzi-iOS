import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let targets: [Target] = [
    .feature(
        factory: .init(
            dependencies: [
                .feature(implements: .Login),
                .feature(interface: .Home),
                .feature(implements: .PieceCreation),
                .domain,
            ]
        )
    )
]

let project: Project = .makeModule(
    name: "Feature",
    targets: targets
)

