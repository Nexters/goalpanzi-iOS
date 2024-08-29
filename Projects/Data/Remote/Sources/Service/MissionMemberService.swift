//
//  MissionMemberService.swift
//  DataRemote
//
//  Created by Haeseok Lee on 8/11/24.
//

import Foundation
import DomainPlayerInterface
import CoreNetworkInterface
import DataRemoteInterface
import ComposableArchitecture
import Alamofire

extension MissionMemberService: DependencyKey {
    
    public static let liveValue: MissionMemberService = {
        
        let authIntercepter = AuthInterceptor()
        
        return Self(
            getMissionMembersMe: {
                let endPoint = Endpoint<GetMissionMembersMeResponseDTO>(
                    path: "api/mission-members/me",
                    httpMethod: .get
                )
                
                let response = await NetworkProvider.shared.sendRequest(endPoint, interceptor: authIntercepter)
                
                switch response {
                case .success(let response):
                    return response.toDomain
                case .failure(let error):
                    throw error
                }
            },
            getMissionMembersRank: { missionId in
                let endPoint = Endpoint<GetMissionMemberRankResponseDTO>(
                    path: "api/mission-members/rank",
                    httpMethod: .get,
                    queryParameters: GetMissionMemberRankRequestDTO(missionId: missionId)
                )
                
                let response = await NetworkProvider.shared.sendRequest(endPoint, interceptor: authIntercepter)
                
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

extension GetMissionMemberRankResponseDTO {
    
    var toDomain: MissionRank {
        .init(rank: rank)
    }
}

extension GetMissionMembersMeResponseDTO {
    
    var toDomain: MyMissionInfo {
        .init(
            profile: .init(nickname: profile.nickname, characterType: profile.characterType),
            missions: missions.map {
                .init(missionId: $0.missionId, description: $0.description)
            }
        )
    }
}
