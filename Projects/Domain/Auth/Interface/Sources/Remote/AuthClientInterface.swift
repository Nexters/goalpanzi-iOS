//
//  SocialLoginClient.swift
//  DomainAuthInterface
//
//  Created by Miro on 7/20/24.
//

import Foundation

import Core
import ComposableArchitecture

// TODO: 백엔드랑 소통해서 더 필요한 값 확인하기

public struct AppleLoginInfomation: Equatable {
    public var identityToken: String

    public init(identityToken: String) {
        self.identityToken = identityToken
    }
}

extension AppleLoginInfomation {
    public static let mock = AppleLoginInfomation(identityToken: "1234")
}

// MARK: - AuthClient Client

public struct SocialLoginClient {
    public var appleLogin: @Sendable () async throws -> AppleLoginInfomation

    public init(appleLogin: @escaping @Sendable () async throws -> AppleLoginInfomation) {
        self.appleLogin = appleLogin
    }
}
