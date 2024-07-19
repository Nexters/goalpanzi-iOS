import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Core.name+ModulePath.Core.Keychain.rawValue,
    targets: [    
        .core(
            interface: .Keychain,
            factory: .init()
        ),
        .core(
            implements: .Keychain,
            factory: .init(
                dependencies: [
                    .core(interface: .Keychain)
                ]
            )
        ),
    
        .core(
            testing: .Keychain,
            factory: .init(
                dependencies: [
                    .core(interface: .Keychain)
                ]
            )
        ),
        .core(
            tests: .Keychain,
            factory: .init(
                dependencies: [
                    .core(testing: .Keychain)
                ]
            )
        ),

    ]
)
