//
//  MissionVerificationService.swift
//  DataRemote
//
//  Created by Haeseok Lee on 8/11/24.
//

import Foundation
import DomainCompetitionInterface

public struct MissionVerificationService: MissionVerificationServiceable {
    
    public var postVerificationsMe: @Sendable (Int, Data) async throws -> Void
    
    public var getVerifications: @Sendable (Int, Date) async throws -> MissionVerification
    
    public var getVerificationsMe: @Sendable (Int, Int) async throws -> MissionVerification.VerificationInfo
    
    public init(
        postVerificationsMe: @escaping @Sendable (Int, Data) async throws -> Void,
        getVerifications: @escaping @Sendable (Int, Date) async throws -> MissionVerification,
        getVerificationsMe: @escaping @Sendable (Int, Int) async throws -> MissionVerification.VerificationInfo
    ) {
        self.postVerificationsMe = postVerificationsMe
        self.getVerifications = getVerifications
        self.getVerificationsMe = getVerificationsMe
    }
}
