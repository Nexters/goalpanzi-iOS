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
            decoder.dateDecodingStrategy = .iso8601
            return decoder
        }()
        
        let authIntercepter = AuthInterceptor()
        
        return Self(
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
