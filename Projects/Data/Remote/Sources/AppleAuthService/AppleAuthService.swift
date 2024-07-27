//
//  AppleAuthService.swift
//  DataRemote
//
//  Created by Haeseok Lee on 7/28/24.
//

import Foundation
import DataRemoteInterface
import DomainAuthInterface
import CoreNetworkInterface
import ComposableArchitecture
import SharedUtil

extension AppleAuthService: DependencyKey {
    
    public static let liveValue: Self = {
        return Self(
            signIn: {
                let delegator = AppleAuthDelegator()
                let identityToken = try await delegator.signIn()
                let endpoint = Endpoint<SignInResponseDTO>(
                    path: "api/auth/login/apple",
                    httpMethod: .post,
                    bodyParameters: SignInRequestDTO(identityToken: identityToken)
                )
                let response = try await NetworkProvider.shared.sendRequest(endpoint)
                return response.toDomain
            }
        )
    }()
}

extension SignInResponseDTO {
    
    var toDomain: DomainAuthInterface.SignInInfo {
        .init(accessToken: accessToken, refreshToken: refreshToken, isProfileSet: isProfileSet)
    }
}
