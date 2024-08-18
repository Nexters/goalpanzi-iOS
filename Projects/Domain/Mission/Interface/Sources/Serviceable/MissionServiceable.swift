//
//  MissionServiceable.swift
//  DomainMission
//
//  Created by 김용재 on 8/12/24.
//

import Foundation

public protocol MissionServiceable {
    
    var getMissions: @Sendable (_ missionId: Int) async throws -> Mission { get }
    
    var deleteMissions: @Sendable (_ missionId: Int) async throws -> Mission { get }
    
    var createMission: @Sendable (
        _ missionContent: String,
        _ missionStartTime: Date,
        _ missionEndDate: Date,
        _ timeOfDay:  TimeOfDay,
        _ missionDays: [WeekDay],
        _ authenticationDays: Int
    ) async throws -> (MissionID, InvitationCode) { get }
    
    var fetchMissionInfo: @Sendable (_ invitationCode: String) async throws -> Mission { get }
    
    var joinCompetition: @Sendable (_ inviationCode: String) async throws -> Void { get }
    
    var checkJoinableMission: @Sendable (_ invitationCode: String) async throws -> Mission { get }
}
