//
//  Project.swift
//  AppManifests
//
//  Created by Haeseok Lee on 7/27/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let targets: [Target] = [
    .data(
        factory: .init(
            dependencies: [
                .data(implements: .Remote),
            ]
        )
    )
]


let project: Project = .makeModule(
    name: "Data",
    targets: targets
)
