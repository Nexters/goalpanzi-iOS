//
//  MissionMemberServiceable.swift
//  Domain
//
//  Created by Haeseok Lee on 8/11/24.
//

import Foundation

public protocol MissionMemberServiceable {
    
    var getMissionMembersMe: @Sendable () async throws -> MyMissionInfo { get }
    
    var getMissionMembersRank: @Sendable (_ missionId: Int) async throws -> MissionRank { get }
}

public struct MyMissionInfo {
    
    public struct Pofile {
        public let nickname: String
        public let characterType: String
        
        public init(nickname: String, characterType: String) {
            self.nickname = nickname
            self.characterType = characterType
        }
    }
    
    public struct MissionInfo {
        public let missionId: Int
        public let description: String
        public init(missionId: Int, description: String) {
            self.missionId = missionId
            self.description = description
        }
    }
    
    public let profile: Pofile
    
    public let missions: [MissionInfo]
    
    public init(profile: Pofile, missions: [MissionInfo]) {
        self.profile = profile
        self.missions = missions
    }
}

public struct MissionRank {
    
    public let rank: Int
    
    public init(rank: Int) {
        self.rank = rank
    }
}
