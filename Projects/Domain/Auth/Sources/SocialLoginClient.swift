//
//  SocialLoginClient.swift
//  DomainAuthInterface
//
//  Created by Miro on 7/20/24.
//

import Foundation

import ComposableArchitecture
import DomainAuthInterface

extension SocialLoginClient: DependencyKey {
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
    public var socialLoginClient: SocialLoginClient {
        get { self[SocialLoginClient.self] }
        set { self[SocialLoginClient.self] = newValue }
    }
}
