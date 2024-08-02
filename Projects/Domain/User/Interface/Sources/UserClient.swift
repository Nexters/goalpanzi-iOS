//
//  UserClient.swift
//  DomainUserInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

// 일단 import Piece를 Domain에 넣어두기
import Foundation

import CoreNetworkInterface

public struct UserClient {
        
    public var createProfile: @Sendable (_ nickName: String, Character) async throws -> EmptyResponse

    public init(createProfile: @escaping @Sendable (_ nickName: String, Character) async throws -> EmptyResponse) {
        self.createProfile = createProfile
    }
}
