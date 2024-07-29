//
//  Project.swift
//  AppManifests
//
//  Created by Haeseok Lee on 7/16/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let targets: [Target] = [
    .domain(
        factory: .init(
            dependencies: [
                .domain(implements: .Auth),
                .shared,
                .domain(implements: .User),
                .domain(implements: .Player),
                .domain(implements: .Board),
                .domain(implements: .Competition),
                .domain(implements: .Mission),
                .core
            ]
        )
    )
]

let project: Project = .makeModule(
    name: "Domain",
    targets: targets
)
