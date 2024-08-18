//
//  MissionClient.swift
//  DomainMission
//
//  Created by 김용재 on 8/12/24.
//

import Foundation

import ComposableArchitecture

// MARK: - MissionClient

public typealias MissionID = Int
public typealias InvitationCode = String

public struct MissionClient {
    
    public var createMission: @Sendable (
        _ missionClient: MissionServiceable,
        _ missionContent: String,
        _ missionStartTime: Date,
        _ missionEndDate: Date,
        _ timeOfDay: TimeOfDay,
        _ missionDays: [WeekDay],
        _ authenticationDays: Int
    ) async throws -> (MissionID, InvitationCode)
    
    public var fetchMissionInfo: @Sendable (
        _ missionClient: MissionServiceable,
        _ invitationCode: String
    ) async throws -> Mission
    
    public var joinCompetition: @Sendable (
        _ missionClient: MissionServiceable,
        _ invitationCode: String
    ) async throws -> Void
    
    public var checkJoinableMission: @Sendable (
        _ missionClient: MissionServiceable,
        _ invitationCode: String
    ) async throws -> Mission

    public init(
        createMission: @escaping @Sendable (
            _ missionClient: MissionServiceable,
            _ missionContent: String,
            _ missionStartTime: Date,
            _ missionEndDate: Date,
            _ timeOfDay: TimeOfDay,
            _ missionDays: [WeekDay],
            _ authenticationDays: Int
        ) async throws -> (MissionID, InvitationCode),
        
        fetchMissionInfo: @escaping @Sendable (
            _ missionClient: MissionServiceable,
            _ invitationCode: String
        ) async throws -> Mission,
        
        joinCompetition: @escaping @Sendable (
            _ missionClient: MissionServiceable,
            _ invitationCode: String
        ) async throws -> Void,
        
        checkJoinableMission: @escaping @Sendable (
            _ missionClient: MissionServiceable,
            _ invitationCode: String
        ) async throws -> Mission
    ) {
        self.createMission = createMission
        self.fetchMissionInfo = fetchMissionInfo
        self.joinCompetition = joinCompetition
        self.checkJoinableMission = checkJoinableMission
    }
}
