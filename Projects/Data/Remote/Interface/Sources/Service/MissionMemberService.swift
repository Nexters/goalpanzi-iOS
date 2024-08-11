//
//  MissionMemberService.swift
//  DataRemote
//
//  Created by Haeseok Lee on 8/11/24.
//

import Foundation
import DomainPlayerInterface

public struct MissionMemberService: MissionMemberServiceable {
    
    public var getMissionMembersRank: @Sendable (String) async throws -> MissionRank
    
    public init(getMissionMembersRank: @escaping @Sendable (String) async throws -> MissionRank) {
        self.getMissionMembersRank = getMissionMembersRank
    }
}
