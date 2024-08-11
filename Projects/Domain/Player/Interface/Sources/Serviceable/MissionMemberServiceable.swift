//
//  MissionMemberServiceable.swift
//  Domain
//
//  Created by Haeseok Lee on 8/11/24.
//

import Foundation

public protocol MissionMemberServiceable {
    
    var getMissionMembersRank: @Sendable (_ missionId: String) async throws -> MissionRank { get }
}

public struct MissionRank {
    
    public let rank: Int
    
    public init(rank: Int) {
        self.rank = rank
    }
}
