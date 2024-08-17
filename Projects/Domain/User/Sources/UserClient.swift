//
//  UserClient.swift
//  DomainUser
//
//  Created by 김용재 on 8/2/24.
//

import Foundation

import DomainUserInterface
import CoreNetworkInterface

import ComposableArchitecture

extension UserClient: DependencyKey {
    public static let liveValue: Self = {
        return Self(
            createProfile: { userService, nickname, character in
                return try await userService.createProfile(nickname, character)
            }
        )
    }()
}
