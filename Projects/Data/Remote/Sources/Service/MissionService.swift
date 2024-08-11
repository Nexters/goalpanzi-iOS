//
//  MissionService.swift
//  DataRemote
//
//  Created by Haeseok Lee on 8/11/24.
//

import Foundation
import DomainMissionInterface
import CoreNetworkInterface
import DataRemoteInterface
import ComposableArchitecture
import Alamofire

extension MissionService: DependencyKey {
    
    public static let liveValue: MissionService = {
        
        let jsonDecoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return decoder
        }()
        
        let authIntercepter = AuthInterceptor()
        
        return Self(
            getMissions: { missionID in
                let endPoint = Endpoint<GetMissionResponseDTO>(
                    path: "api/missions/\(missionID)",
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
            deleteMissions: { missionID in
                let endPoint = Endpoint<DeleteMissionResponseDTO>(
                    path: "api/missions/\(missionID)",
                    httpMethod: .delete,
                    queryParameters: EmptyRequest()
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

extension GetMissionResponseDTO {
    
    var toDomain: Mission {
        .init(
            missionId: missionId,
            hostMemeverId: hostMemberId,
            description: description,
            missionStartDate: missionStartDate,
            missionEndDate: missionEndDate,
            timeOfDay: timeOfDay,
            missionDays: missionDays,
            boardCount: boardCount,
            invitationCode: invitationCode
        )
    }
}

extension DeleteMissionResponseDTO {
    
    var toDomain: Mission {
        .init(
            missionId: missionId,
            hostMemeverId: hostMemberId,
            description: description,
            missionStartDate: missionStartDate,
            missionEndDate: missionEndDate,
            timeOfDay: timeOfDay,
            missionDays: missionDays,
            boardCount: boardCount,
            invitationCode: invitationCode
        )
    }
}
