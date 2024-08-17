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
    
    public init(
        getMissionMembersMe: @escaping @Sendable () async throws -> MyMissionInfo,
        getMissionMembersRank: @escaping @Sendable (Int) async throws -> MissionRank
    ) {
        self.getMissionMembersMe = getMissionMembersMe
        self.getMissionMembersRank = getMissionMembersRank
    }
}
