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
        
        let authIntercepter = AuthInterceptor()
        
        return Self(
            getMissions: { missionID in
                let endPoint = Endpoint<GetMissionResponseDTO>(
                    path: "api/missions/\(missionID)",
                    httpMethod: .get
                )
                
                do {
                    let response = try await NetworkProvider.shared.sendRequest(endPoint, interceptor: authIntercepter)
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
                    let response = try await NetworkProvider.shared.sendRequest(endPoint, interceptor: authIntercepter)
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
