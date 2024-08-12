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
        _ missionDays: [Weekday],
        _ authenticationDays: Int
    ) async throws -> (MissionID, InvitationCode)
    
    public var fetchMissionInfo: @Sendable (
        _ missionClient: MissionServiceable,
        _ invitationCode: String
    ) async throws -> (InvitationCode, Mission)

    public init(
        createMission: @escaping @Sendable (
            _ missionClient: MissionServiceable,
            _ missionContent: String,
            _ missionStartTime: Date,
            _ missionEndDate: Date,
            _ timeOfDay: TimeOfDay,
            _ missionDays: [Weekday],
            _ authenticationDays: Int
        ) async throws -> (MissionID, InvitationCode),
        
        fetchMissionInfo: @escaping @Sendable (
            _ missionClient: MissionServiceable,
            _ invitationCode: String
        ) async throws -> (InvitationCode, Mission)
    ) {
        self.createMission = createMission
        self.fetchMissionInfo = fetchMissionInfo
    }
}
