//
//  UserClient.swift
//  DomainUserInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

// 일단 import Piece를 Domain에 넣어두기
import Foundation

import CoreNetworkInterface
import Alamofire

public enum UserClientError: Error {
    case duplicateNickName
    case networkDisabled
}

public struct UserClient {

    public typealias Nickname = String

    public var createProfile: @Sendable (_ userService: UserServiceable, Nickname, Character) async throws -> Void

    public init(createProfile: @escaping @Sendable (_ userService: UserServiceable, Nickname, Character) async throws -> Void) {
        self.createProfile = createProfile
    }
}
