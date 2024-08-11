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
                let requestDTO = CreateMissionRequestDTO(description: missionContent, missionStartDate: missionStartTime, missionEndDate: missionEndDate, timeOfDay: timeOfDay.description, missionDays: missionDays, boardCount: authenticationDays)
                
                let endPoint = Endpoint<CreateMissionResponseDTO>(
                    path: "api/missions", httpMethod: .post, bodyParameters: requestDTO)
                
                let response = try await NetworkProvider.shared.sendRequest(endPoint, interceptor: interceptor)
                
                return (response.missionId, response.invitationCode)
            }
        )
    }()
}
