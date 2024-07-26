//
//  SocialLoginAuthInterface.swift
//  DomainAuth
//
//  Created by 김용재 on 7/26/24.
//

import Foundation

import Core
import ComposableArchitecture

public struct AppleLoginInfomation: Equatable {
    public var identityToken: String

    public init(identityToken: String) {
        self.identityToken = identityToken
    }
}

extension AppleLoginInfomation {
    public static let mock = AppleLoginInfomation(identityToken: "1234")
}

// MARK: - SocialLoginAuth

public struct SocialLoginAuth {
    public var appleLogin: @Sendable () async throws -> AppleLoginInfomation

    public init(appleLogin: @escaping @Sendable () async throws -> AppleLoginInfomation) {
        self.appleLogin = appleLogin
    }
}
