//
//  AuthClientInterface.swift
//  DomainAuthInterface
//
//  Created by Miro on 7/20/24.
//
import Foundation

import ComposableArchitecture

// MARK: - AuthClient

public struct AuthClient {
    
    @Dependency(AuthServiceKey.self) var authService
    
    // TODO: 로그아웃 및 다른 method도 추가하기
    public var signIn: @Sendable (_ identityToken: String) async throws -> SignIn

    public init(signIn: @escaping @Sendable (_ identityToken: String) async throws -> SignIn) {
        self.signIn = signIn
    }
}


public struct AuthServiceKey {}

public protocol AuthServicable {
    func signInWithApple(identityToken: String) async throws -> SignIn
}

public struct SignIn {
    public let accessToken: String
    public let refreshToken: String
    public let isProfileSet: Bool
    
    public init(accessToken: String, refreshToken: String, isProfileSet: Bool) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.isProfileSet = isProfileSet
    }
}
