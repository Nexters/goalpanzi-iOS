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
import Alamofire

extension AppleAuthService: DependencyKey {
    
    public static let liveValue: Self = {
        let interceptor = AuthInterceptor()

        return Self(
            signIn: {
                let identityToken = try await AppleAuthProvider().signIn()
                let endpoint = Endpoint<SignInResponseDTO>(
                    path: "api/auth/login/apple",
                    httpMethod: .post,
                    bodyParameters: SignInRequestDTO(identityToken: identityToken)
                )
                let response = try await NetworkProvider.shared.sendRequest(endpoint, interceptor: nil)
                return response.toDomain
            },
            logout: {
                let endpoint = Endpoint<Empty>(
                    path: "api/auth/logout",
                    httpMethod: .post
                )
                
                do {
                    let _ = try await NetworkProvider.shared.sendRequest(endpoint, interceptor: interceptor)
                } catch {
                    throw AuthClientError.logoutFailed
                }
            }
        )
    }()
}

extension SignInResponseDTO {
    
    var toDomain: DomainAuthInterface.SignInInfo {
        .init(accessToken: accessToken, refreshToken: refreshToken, isProfileSet: isProfileSet)
    }
}
