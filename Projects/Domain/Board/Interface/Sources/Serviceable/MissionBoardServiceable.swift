//
//  MissionBoardServiceable.swift
//  Domain
//
//  Created by Haeseok Lee on 8/11/24.
//

import Foundation

public protocol MissionBoardServiceable {
    
    var getBoard: @Sendable (_ missionID: String) async throws -> MissionBoard { get }
}

public struct MissionBoard {
    
    public struct BoardInfo {
        public let number: Int
        public let reward: String
        public let missionBoardMembers: [BoardMember]
        
        public init(number: Int, reward: String, missionBoardMembers: [BoardMember]) {
            self.number = number
            self.reward = reward
            self.missionBoardMembers = missionBoardMembers
        }
    }
    
    public struct BoardMember {
        public let nickname: String
        public let characterType: String
        
        public init(nickname: String, characterType: String) {
            self.nickname = nickname
            self.characterType = characterType
        }
    }
    
    public let missionBoards: [BoardInfo]
    
    public init(missionBoards: [BoardInfo]) {
        self.missionBoards = missionBoards
    }
}
