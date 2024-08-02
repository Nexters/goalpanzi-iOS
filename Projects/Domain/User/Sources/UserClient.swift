//
//  UserClient.swift
//  DomainUser
//
//  Created by 김용재 on 8/2/24.
//

import Foundation

import ComposableArchitecture

import DomainUserInterface
import CoreNetworkInterface

extension UserClient: DependencyKey {

    public static let liveValue: Self = {
        
        return Self(
            createProfile: { (nickname, piece) in
                let requestDTO = CreatProfileRequestDTO(
                    nickname: nickname,
                    characterType: piece.rawValue
                )
                let endpoint = Endpoint<EmptyResponse>(
                    path: "api/auth/login/apple",
                    httpMethod: .post,
                    bodyParameters: requestDTO
                )
                let response = try await NetworkProvider.shared.sendRequest(endpoint)
                return response
            }
        )
    }()
}
