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
    // TODO: 로그아웃 및 다른 method도 추가하기
    public var signIn: @Sendable (SignInRequestDTO) async throws -> SignInResponseDTO

    public init(signIn: @escaping @Sendable (SignInRequestDTO) async throws -> SignInResponseDTO) {
        self.signIn = signIn
    }
}
