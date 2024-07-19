//
//  AuthClient.swift
//  DomainAuthInterface
//
//  Created by Miro on 7/20/24.
//

import Foundation

import ComposableArchitecture

// TODO: 백엔드랑 소통해서 더 필요한 값 확인하기

public struct AppleLoginInfomation {
    var identityToken: String
}

extension AppleLoginInfomation {
    static let mock = AppleLoginInfomation(identityToken: "1234")
}

// MARK: - AuthClient Client

public struct AuthClient {
    public var appleLogin: @Sendable () async throws -> AppleLoginInfomation
}
