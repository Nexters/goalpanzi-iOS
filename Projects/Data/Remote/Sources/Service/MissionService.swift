//
//  MissionService.swift
//  DataRemote
//
//  Created by 김용재 on 8/12/24.
//

import Foundation

import CoreNetworkInterface
import DataRemoteInterface
import DomainMissionInterface
import SharedUtil
import ComposableArchitecture
import Alamofire

extension MissionService: DependencyKey {
    
    public static let liveValue: Self = {
        let interceptor = AuthInterceptor()

        return Self(
            getMissions: { missionID in
                let endPoint = Endpoint<GetMissionResponseDTO>(
                    path: "api/missions/\(missionID)",
                    httpMethod: .get
                )
                
                let response = await NetworkProvider.shared.sendRequest(endPoint, interceptor: interceptor)
                
                switch response {
                case .success(let response):
                    return response.toDomain
                case .failure(let error):
                    throw error
                }
                
                
            },
            deleteMissions: { missionID in
                let endPoint = Endpoint<Empty>(
                    path: "api/missions/\(missionID)",
                    httpMethod: .delete
                )
                
                let response = await NetworkProvider.shared.sendRequest(endPoint, interceptor: interceptor)
                
                switch response {
                case .success:
                    return
                case .failure(let error):
                    throw error
                }
            },
            createMission: { missionContent, missionStartTime, missionEndDate, timeOfDay, missionDays, authenticationDays in
                
                let missionStartTime = missionStartTime.formattedString(dateFormat: .longYearMonthDateTimeZone)
                let missionEndDate = missionEndDate.formattedString(dateFormat: .longYearMonthDateTimeZone)
                let missionDays = missionDays.map { $0.rawValue }
                let requestDTO = CreateMissionRequestDTO(
                    description: missionContent,
                    missionStartDate: missionStartTime,
                    missionEndDate: missionEndDate,
                    timeOfDay: timeOfDay.rawValue,
                    missionDays: missionDays,
                    boardCount: authenticationDays
                )

                let endPoint = Endpoint<CreateMissionResponseDTO>(
                    path: "api/missions", httpMethod: .post, bodyParameters: requestDTO)
                
                let response = await NetworkProvider.shared.sendRequest(endPoint, interceptor: interceptor)
                
                switch response {
                case .success(let response):
                    return response.toDomain
                case .failure(let error):
                    throw error
                }
            },
            
            fetchMissionInfo: { invitationCode in
                let requestDTO = FetchMissionInfoRequestDTO(invitationCode: invitationCode)
                let endPoint = Endpoint<FetchMissionInfoResponseDTO>(
                    path: "api/missions", httpMethod: .get, queryParameters: requestDTO)
                let response = await NetworkProvider.shared.sendRequest(endPoint, interceptor: interceptor)
                
                switch response {
                case .success(let response):
                    return response.toDomain
                case .failure(let error):
                    throw error
                }
            },
            
            joinCompetition: { invitationCode in
                let requestDTO = JoinCompetitionRequestDTO(invitationCode: invitationCode)

                let endPoint = Endpoint<Empty>(
                    path: "api/mission-members",
                    httpMethod: .post,
                    bodyParameters: requestDTO
                )
                
                let response = await NetworkProvider.shared.sendRequest(endPoint, interceptor: interceptor)
                
                if case .failure(let failure) = response {
                    throw failure
                }
            },
            
            checkJoinableMission: { invitationCode in
                let requestDTO = CheckJoinableMissionRequestDTO(invitationCode: invitationCode)
                let endPoint = Endpoint<CheckJoinableMissionResponseDTO>(
                    path: "api/mission:joinable", httpMethod: .get, queryParameters: requestDTO)
                let response = await NetworkProvider.shared.sendRequest(endPoint, interceptor: interceptor)
                
                switch response {
                case .success(let response):
                    return response.toDomain
                case .failure(let error):
                    throw MissionClientError(rawValue: error.message) ?? NSError()
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
            startDate: missionStartDate,
            endDate: missionEndDate,
            timeOfDay: TimeOfDay(rawValue: timeOfDay) ?? .everyday,
            verificationWeekDays: missionDays.compactMap { WeekDay(rawValue: $0) },
            verificationDays: boardCount,
            invitationCode: invitationCode
        )
    }
}
    
extension CreateMissionResponseDTO {
    
    var toDomain: (MissionID, InvitationCode) {
        return (self.missionId, self.invitationCode)
    }
}

extension FetchMissionInfoResponseDTO {
    var toDomain: Mission {
        let timeOfDay = TimeOfDay(rawValue: self.timeOfDay) ?? .afternoon
        let startDate = self.missionStartDate.toDate(format: .longYearMonthDateTimeZone) ?? Date()
        let endDate = self.missionEndDate.toDate(format: .compactYearMonthDateTime) ?? Date()
        let verificationWeekDays = self.missionDays.map { WeekDay(rawValue: $0) ?? .friday }
        
        return .init(
            missionId: missionId, 
            hostMemberId: hostMemberId,
            description: description,
            startDate: startDate,
            endDate: endDate,
            timeOfDay: timeOfDay,
            verificationWeekDays: verificationWeekDays,
            verificationDays: boardCount,
            invitationCode: invitationCode
        )
    }
}

extension CheckJoinableMissionResponseDTO {
    var toDomain: Mission {
        .init(
            missionId: missionId,
            hostMemberId: hostMemberId,
            description: description,
            startDate: missionStartDate,
            endDate: missionEndDate,
            timeOfDay: TimeOfDay(rawValue: timeOfDay) ?? .everyday,
            verificationWeekDays: missionDays.compactMap { WeekDay(rawValue: $0) },
            verificationDays: boardCount,
            invitationCode: invitationCode
        )
    }
}
