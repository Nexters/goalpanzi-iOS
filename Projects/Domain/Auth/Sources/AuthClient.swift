//
//  AuthClient.swift
//  DomainAuthInterface
//
//  Created by Miro on 7/20/24.
//

import Foundation

import ComposableArchitecture
import DomainAuthInterface

extension AuthClient: DependencyKey {
    public static let liveValue: Self = {
        let appleLoginController = AppleLoginController()

        return Self(
            appleLogin: {
                return try await appleLoginController.login()
            }
        )
    }()

    public static let previewValue: Self = {
        Self(
            appleLogin: { .mock }
        )
    }()
}

extension DependencyValues {
    public var auclient: AuthClient {
        get { self[AuthClient.self] }
        set { self[AuthClient.self] = newValue }
    }
}
