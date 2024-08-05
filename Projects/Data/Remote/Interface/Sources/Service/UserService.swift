//
//  UserService.swift
//  DataRemoteInterface
//
//  Created by Miro on 8/3/24.
//

import Foundation

import DomainUserInterface

public struct UserService: UserServiceable {

    public var createProfile: @Sendable (_ nickName: String, DomainUserInterface.Character) async throws -> Void

    public init(createProfile: @escaping @Sendable (_ nickName: String, DomainUserInterface.Character) async throws -> Void) {
        self.createProfile = createProfile
    }
}