//
//  MissionVerificationServiceable.swift
//  Domain
//
//  Created by Haeseok Lee on 8/11/24.
//

import Foundation

public protocol MissionVerificationServiceable {
    
    var postVerificationsMe: @Sendable (_ missionID: Int, _ imageName: String, _ imageJPEGData: Data) async throws -> Void { get }
    
    var getVerifications: @Sendable (_ missionID: Int, _ date: Date) async throws -> MissionVerification { get }
    
    var getVerificationsMe: @Sendable (_ missionID: Int, _ number: Int) async throws -> MissionVerification.VerificationInfo { get }
}

public struct MissionVerification {
    
    public struct VerificationInfo {
        public let nickname: String
        public let characterType: String
        public let imageUrl: String
        public let verifiedAt: Date?
        public init(nickname: String, characterType: String, imageUrl: String, verifiedAt: Date?) {
            self.nickname = nickname
            self.characterType = characterType
            self.imageUrl = imageUrl
            self.verifiedAt = verifiedAt
        }
    }
    
    public let missionVerifications: [VerificationInfo]
    
    public init(missionVerifications: [VerificationInfo]) {
        self.missionVerifications = missionVerifications
    }
}
