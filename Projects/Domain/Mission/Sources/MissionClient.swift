//
//  MissionClient.swift
//  DomainMission
//
//  Created by 김용재 on 8/12/24.
//

import Foundation

import DomainMissionInterface
import CoreNetworkInterface

import ComposableArchitecture

extension MissionClient: DependencyKey {
    public static let liveValue: Self = {
        return Self(
            createMission: { missionService, missionContent, missionStartTime, missionEndDate, timeOfDay, missionDays, authenticationDays in
            try await missionService.createMission(
                missionContent,
                missionStartTime,
                missionEndDate,
                timeOfDay,
                missionDays,
                authenticationDays)
            },
            fetchMissionInfo: { missionService, invitationCode in
                try await missionService.fetchMissionInfo(invitationCode)
            },
            joinCompetition: { missionService, invitationCode in
                try await missionService.joinCompetition(invitationCode)
            }
        )
    }()
}
