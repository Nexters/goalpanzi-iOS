//
//  AuthEndPoint.swift
//  DomainAuth
//
//  Created by 김용재 on 7/26/24.
//

import Foundation

import DomainAuthInterface
import CoreNetworkInterface

public struct AuthEndpoint {
    public static func signInWithApple(_ requestDTO: SignInRequestDTO) -> Endpoint<SignInResponseDTO> {
        return Endpoint(path: "api/auth/login/apple", httpMethod: .post, bodyParameters: requestDTO)
    }
}
