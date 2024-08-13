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
        
        let jsonDecoder: JSONDecoder = {
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            return decoder
        }()
        
        let authIntercepter = AuthInterceptor()
        
        return Self(
            getMissionMembersMe: {
                let endPoint = Endpoint<GetMissionMembersMeResponseDTO>(
                    path: "api/mission-members/me",
                    httpMethod: .get,
                    queryParameters: EmptyRequest()
                )
                
                do {
                    let response = try await NetworkProvider.shared.sendRequest(endPoint, decoder: jsonDecoder, interceptor: authIntercepter)
                    return response.toDomain
                } catch {
                    throw NSError()
                }
            },
            getMissionMembersRank: { missionId in
                let endPoint = Endpoint<GetMissionMemberRankResponseDTO>(
                    path: "api/mission-members/rank",
                    httpMethod: .get,
                    queryParameters: GetMissionMemberRankRequestDTO(missionId: missionId)
                )
                
                do {
                    let response = try await NetworkProvider.shared.sendRequest(endPoint, decoder: jsonDecoder, interceptor: authIntercepter)
                    return response.toDomain
                } catch {
                    throw NSError()
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
