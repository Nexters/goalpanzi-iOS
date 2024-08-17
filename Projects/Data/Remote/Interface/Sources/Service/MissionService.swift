//
//  MissionService.swift
//  DataRemote
//
//  Created by 김용재 on 8/12/24.
//

import Foundation

import DomainMissionInterface

public struct MissionService: MissionServiceable {
    
    public var getMissions: @Sendable (Int) async throws -> Mission
    
    public var deleteMissions: @Sendable (Int) async throws -> Mission
    
    public var createMission: @Sendable (
        _ missionContent: String,
        _ missionStartTime: Date,
        _ missionEndDate: Date,
        _ timeOfDay: TimeOfDay,
        _ missionDays: [WeekDay],
        _ authenticationDays: Int
    ) async throws -> (MissionID, InvitationCode)
    
    public var fetchMissionInfo: @Sendable (
        _ invitationCode: String
    ) async throws -> Mission
    
    public var joinCompetition: @Sendable (
        _ invitationCode: String
    ) async throws -> Void
    
    public init(
        getMissions: @escaping @Sendable (Int) async throws -> Mission,
        deleteMissions: @escaping @Sendable (Int) async throws -> Mission,
        createMission: @escaping @Sendable (
            _ missionContent: String,
            _ missionStartTime: Date,
            _ missionEndDate: Date,
            _ timeOfDay: TimeOfDay,
            _ missionDays: [WeekDay],
            _ authenticationDays: Int
        ) async throws -> (MissionID, InvitationCode),
        
        fetchMissionInfo: @escaping @Sendable (
            _ invitationCode: String
        ) async throws -> Mission,
        
        joinCompetition: @escaping @Sendable (
            _ invitationCode: String
        ) async throws -> Void
    ) {
        self.getMissions = getMissions
        self.deleteMissions = deleteMissions
        self.createMission = createMission
        self.fetchMissionInfo = fetchMissionInfo
        self.joinCompetition = joinCompetition
    }
}
