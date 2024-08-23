//
//  UserService.swift
//  DataRemoteInterface
//
//  Created by Miro on 8/3/24.
//

import Foundation

import CoreNetworkInterface
import DataRemoteInterface
import DomainUserInterface

import ComposableArchitecture
import Alamofire

extension UserService: DependencyKey {

    public static let liveValue: Self = {
        let interceptor = AuthInterceptor()

        return Self(
            createProfile: { nickname, character in
                let requestDTO = CreatProfileRequestDTO(nickname: nickname, characterType: character.rawValue)

                let endPoint = Endpoint<Empty>(
                    path: "api/member/profile",
                    httpMethod: .patch,
                    bodyParameters: requestDTO
                )
                
                let response = await NetworkProvider.shared.sendRequest(endPoint, interceptor: interceptor)
                
                if case .failure(let failure) = response {
                    throw UserClientError.duplicateNickName
                }
            },
            
            deleteProfile: {
                let endpoint = Endpoint<Empty>(
                    path: "api/member",
                    httpMethod: .delete
                )
                
                let response = await NetworkProvider.shared.sendRequest(endpoint, interceptor: interceptor)
                
                if case .failure(let failure) = response {
                    throw failure
                }
            },
            
            checkProfile: {
                let endpoint = Endpoint<CheckProfileResponseDTO>(
                    path: "api/member/profile",
                    httpMethod: .get
                )
                
                let response = await NetworkProvider.shared.sendRequest(endpoint, interceptor: interceptor)
                
                switch response {
                case .success(let response):
                    return response.toDomain
                case .failure(let error):
                    throw error
                }
            }
        )
    }()
}

extension CheckProfileResponseDTO {
    
    var toDomain: UserProfile {
        return .init(nickname: nickname, character: Character(rawValue: characterType) ?? .rabbit)
    }
}
