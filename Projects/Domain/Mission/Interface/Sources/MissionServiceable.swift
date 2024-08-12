//
//  MissionServiceable.swift
//  DomainMission
//
//  Created by 김용재 on 8/12/24.
//

import Foundation

public protocol MissionServiceable {
    
    var createMission: @Sendable (
        _ missionContent: String,
        _ missionStartTime: Date,
        _ missionEndDate: Date,
        _ timeOfDay:  TimeOfDay,
        _ missionDays: [Weekday],
        _ authenticationDays: Int
    ) async throws -> (MissionID, InvitationCode) { get }
    
    var fetchMissionInfo: @Sendable (
        _ invitationCode: String
    ) async throws -> (InvitationCode, Mission) { get }
    
}
