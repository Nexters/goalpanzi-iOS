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
                
                do {
                    let _ = try await NetworkProvider.shared.sendRequest(endPoint, interceptor: interceptor)
                } catch {
                    throw UserClientError.duplicateNickName
                }
            },
            deleteProfile: {
                let endpoint = Endpoint<Empty>(
                    path: "api/member",
                    httpMethod: .post
                )
                
                do {
                    let _ = try await NetworkProvider.shared.sendRequest(endpoint, interceptor: interceptor)
                } catch {
                    throw UserClientError.deleteProfileFailed
                }
            }
        )
    }()
}
