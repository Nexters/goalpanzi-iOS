//
//  MissionVerificationService.swift
//  DataRemote
//
//  Created by Haeseok Lee on 8/11/24.
//

import Foundation
import DomainCompetitionInterface

public struct MissionVerificationService: MissionVerificationServiceable {
    
    public var postVerificationsMe: @Sendable (String, String, Data) async throws -> Void
    
    public var getVerifications: @Sendable (String, Date) async throws -> MissionVerification
    
    public var getVerificationsMe: @Sendable (String, Int) async throws -> MissionVerification.VerificationInfo
    
    public init(
        postVerificationsMe: @escaping @Sendable (String, String, Data) async throws -> Void,
        getVerifications: @escaping @Sendable (String, Date) async throws -> MissionVerification,
        getVerificationsMe: @escaping @Sendable (String, Int) async throws -> MissionVerification.VerificationInfo
    ) {
        self.postVerificationsMe = postVerificationsMe
        self.getVerifications = getVerifications
        self.getVerificationsMe = getVerificationsMe
    }
}
