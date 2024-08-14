//
//  AuthClientInterface.swift
//  DomainAuthInterface
//
//  Created by Miro on 7/20/24.
//
import Foundation

import ComposableArchitecture

public enum AuthClientError: Error {
    case logoutFailed
}

public struct AuthClient {
    
    // TODO: 로그아웃 및 다른 method도 추가하기
    public var signInWithApple: @Sendable (_ appleAuthService: AppleAuthServiceable) async throws -> SignInInfo

    public init(signInWithApple: @escaping @Sendable (_ appleAuthService: AppleAuthServiceable) async throws -> SignInInfo) {
        self.signInWithApple = signInWithApple
    }
}
