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
    public var deleteProfile: @Sendable () async throws -> Void
    public var checkProfile: @Sendable () async throws -> UserProfile

    public init(
        createProfile: @escaping @Sendable (_ nickName: String, DomainUserInterface.Character) async throws -> Void,
        deleteProfile: @escaping @Sendable () async throws -> Void,
        checkProfile: @escaping @Sendable () async throws -> UserProfile
    ) {
        self.createProfile = createProfile
        self.deleteProfile = deleteProfile
        self.checkProfile = checkProfile
    }
}
