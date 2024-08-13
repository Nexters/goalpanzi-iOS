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
                
                let response = try await NetworkProvider.shared.sendRequest(endPoint, interceptor: interceptor)

                return response.toDomain
            },
            
            fetchMissionInfo: { invitationCode in
                let requestDTO = FetchMissionInfoRequestDTO(invitationCode: invitationCode)
                let endPoint = Endpoint<FetchMissionInfoResponseDTO>(
                    path: "api/missions", httpMethod: .get, queryParameters: requestDTO)
                let response = try await NetworkProvider.shared.sendRequest(endPoint, interceptor: interceptor)
                 
                return response.toDomain
            },
            
            joinCompetition: { invitationCode in
                let requestDTO = JoinCompetitionRequestDTO(invitationCode: invitationCode)

                let endPoint = Endpoint<Empty>(
                    path: "api/mission-members",
                    httpMethod: .post,
                    bodyParameters: requestDTO
                )
                
                _ = try await NetworkProvider.shared.sendRequest(endPoint, interceptor: interceptor)
            }
        )
    }()
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
        let authenticationWeekDays = self.missionDays.map { Weekday(rawValue: $0) ?? .friday }
        
        return .init(
            missionId: missionId,
            description: description,
            startDate: startDate,
            endDate: endDate,
            timeOfDay: timeOfDay,
            authenticationWeekDays: authenticationWeekDays,
            authenticationDays: boardCount,
            invitationCode: invitationCode
        )
    }
}
