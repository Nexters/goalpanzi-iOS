//
//  UserClient.swift
//  DomainUserInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

// 일단 import Piece를 Domain에 넣어두기
import Foundation

public enum UserClientError: Error {
    case duplicateNickName
    case deleteProfileFailed
    case networkDisabled
    case checkProfileFailed
}

public struct UserClient {

    public typealias Nickname = String

    public var createProfile: @Sendable (_ userService: UserServiceable, Nickname, Character) async throws -> Void
    public var deleteProfile: @Sendable (_ userService: UserServiceable) async throws -> Void
    public var checkProfile: @Sendable (_ userService: UserServiceable) async throws -> UserProfile

    public init(
        createProfile: @escaping @Sendable (_ userService: UserServiceable, Nickname, Character) async throws -> Void,
        deleteProfile: @escaping @Sendable (_ userService: UserServiceable) async throws -> Void,
        checkProfile: @escaping @Sendable (_ userService: UserServiceable) async throws -> UserProfile
    ) {
        self.createProfile = createProfile
        self.deleteProfile = deleteProfile
        self.checkProfile = checkProfile
    }
}
