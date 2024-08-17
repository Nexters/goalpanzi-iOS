//
//  AuthClient.swift
//  DomainAuth
//
//  Created by 김용재 on 7/26/24.
//

import Foundation

import ComposableArchitecture
import DomainAuthInterface
import CoreKeychainInterface

extension AuthClient: DependencyKey {
    public static let liveValue: Self = {
        return Self(
            signInWithApple: { appleAuthService in
                let response = try await appleAuthService.signIn()
                return response
            },
            logout: { appleAuthService in
                return try await appleAuthService.logout()
            }
        )
    }()
}
