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
    
    var completeMission: @Sendable (_ missionId: Int) async throws -> Void { get }
}

public struct MyMissionInfo {
    
    public struct Profile {
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
        public let missionStatus: String
        public init(missionId: Int, description: String, missionStatus: String) {
            self.missionId = missionId
            self.description = description
            self.missionStatus = missionStatus
        }
    }
    
    public let profile: Profile
    
    public let missions: [MissionInfo]
    
    public init(profile: Profile, missions: [MissionInfo]) {
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
