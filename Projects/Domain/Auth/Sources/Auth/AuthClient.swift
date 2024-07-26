//
//  AuthClient.swift
//  DomainAuth
//
//  Created by 김용재 on 7/26/24.
//

import Foundation

import ComposableArchitecture
import DomainAuthInterface
import CoreNetworkInterface

extension AuthClient: DependencyKey {
    public static let liveValue: Self = {

        return Self(
            signIn: {
                let endPoint = AuthEndpoint.signInWithApple($0)
                let response = try await NetworkProvider.shared.sendRequest(endPoint)
                return response
            }
        )
    }()
}

extension DependencyValues {
    public var authClient: AuthClient {
        get { self[AuthClient.self] }
        set { self[AuthClient.self] = newValue }
    }
}
