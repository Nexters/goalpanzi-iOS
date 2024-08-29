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
                let response = await NetworkProvider.shared.sendRequest(endpoint, interceptor: nil)
                
                switch response {
                case .success(let response):
                    return response.toDomain
                case .failure(let error):
                    throw error
                }
            },
            logout: {
                let endpoint = Endpoint<Empty>(
                    path: "api/auth/logout",
                    httpMethod: .post
                )
                
                let response = await NetworkProvider.shared.sendRequest(endpoint, interceptor: interceptor)
                
                if case .failure(let failure) = response {
                    throw failure
                }
            }
        )
    }()
}

extension SignInResponseDTO {
    
    var toDomain: DomainAuthInterface.SignInInfo {
        .init(accessToken: accessToken, refreshToken: refreshToken, isProfileSet: isProfileSet, memberId: memberId)
    }
}
