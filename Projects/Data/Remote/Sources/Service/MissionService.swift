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
            decoder.dateDecodingStrategy = .formatted(.serverTimeFormatter)
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
                    print(error)
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
            hostMemberId: hostMemberId,
            description: description,
            missionStartDate: missionStartDate,
            missionEndDate: missionEndDate,
            timeOfDay: TimeOfDay(rawValue: timeOfDay) ?? .everyday,
            missionDays: missionDays.compactMap { WeekDay(rawValue: $0) },
            boardCount: boardCount,
            invitationCode: invitationCode
        )
    }
}

extension DeleteMissionResponseDTO {
    
    var toDomain: Mission {
        .init(
            missionId: missionId,
            hostMemberId: hostMemberId,
            description: description,
            missionStartDate: missionStartDate,
            missionEndDate: missionEndDate,
            timeOfDay: TimeOfDay(rawValue: timeOfDay) ?? .everyday,
            missionDays: missionDays.compactMap { WeekDay(rawValue: $0) },
            boardCount: boardCount,
            invitationCode: invitationCode
        )
    }
}
