//
//  MissionMemberService.swift
//  DataRemote
//
//  Created by Haeseok Lee on 8/11/24.
//

import Foundation
import DomainPlayerInterface

public struct MissionMemberService: MissionMemberServiceable {
    
    public var getMissionMembersMe: @Sendable () async throws -> MyMissionInfo

    public var getMissionMembersRank: @Sendable (Int) async throws -> MissionRank
    
    public var completeMission: @Sendable (Int) async throws -> Void
    
    public init(
        getMissionMembersMe: @escaping @Sendable () async throws -> MyMissionInfo,
        getMissionMembersRank: @escaping @Sendable (Int) async throws -> MissionRank,
        completeMission: @escaping @Sendable (Int) async throws -> Void
    ) {
        self.getMissionMembersMe = getMissionMembersMe
        self.getMissionMembersRank = getMissionMembersRank
        self.completeMission = completeMission
    }
}
