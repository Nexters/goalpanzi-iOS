//
//  Project.swift
//  ApplicationManifests
//
//  Created by Haeseok Lee on 7/16/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let targets: [Target] = [
    .core(
        factory: .init(
            dependencies: [
                .core(implements: .Network),
                .core(implements: .Keychain),
                .shared
            ]
        )
    )
]


let project: Project = .makeModule(
    name: "Core",
    targets: targets
)
