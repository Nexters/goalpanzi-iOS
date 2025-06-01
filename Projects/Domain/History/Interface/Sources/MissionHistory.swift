// This is for Tuist
import Foundation
import DomainUserInterface

public struct MissionHistoryInfo {
    
    public static let empty: Self = .init(
        totalCount: 0,
        hasNext: false,
        resultList: []
    )
    
    public struct History {
        public let missionId: Int
        public let description: String
        public let missionStartDate: Date
        public let missionEndDate: Date
        public let myVerificationCount: Int
        public let totalVerificationCount: Int
        public let rank: Int
        public let randomImageUrlList: [URL]
        public let memberCount: Int
        public let missionMembers: [Member]
        
        public init(
            missionId: Int,
            description: String,
            missionStartDate: Date,
            missionEndDate: Date,
            myVerificationCount: Int,
            totalVerificationCount: Int,
            rank: Int,
            randomImageUrlList: [URL],
            memberCount: Int,
            missionMembers: [Member]
        ) {
            self.missionId = missionId
            self.description = description
            self.missionStartDate = missionStartDate
            self.missionEndDate = missionEndDate
            self.myVerificationCount = myVerificationCount
            self.totalVerificationCount = totalVerificationCount
            self.rank = rank
            self.randomImageUrlList = randomImageUrlList
            self.memberCount = memberCount
            self.missionMembers = missionMembers
        }
    }
    
    public struct Member {
        public let memberId: Int
        public let nickname: String
        public let character: Character
        
        public init(
            memberId: Int,
            nickname: String,
            character: Character
        ) {
            self.memberId = memberId
            self.nickname = nickname
            self.character = character
        }
    }
    
    public let totalCount: Int
    public let hasNext: Bool
    public let resultList: [History]
    public var isEmpty: Bool { resultList.isEmpty }
    
    
    
    public init(
        totalCount: Int,
        hasNext: Bool,
        resultList: [History]
    ) {
        self.totalCount = totalCount
        self.hasNext = hasNext
        self.resultList = resultList
    }
}

extension MissionHistoryInfo.History: Identifiable {
    
    public var id: Int { missionId }
}

extension MissionHistoryInfo.History {
    
    public var characters: [Character] {
        missionMembers.map(\.character)
    }
}
