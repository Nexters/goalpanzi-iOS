//
//  MissionService.swift
//  DataRemote
//
//  Created by Haeseok Lee on 8/11/24.
//

import Foundation
import DomainMissionInterface

public struct MissionService: MissionServiceable {
    
    public var getMissions: @Sendable (String) async throws -> Mission
    
    public var deleteMissions: @Sendable (String) async throws -> Mission
    
    public init(
        getMissions: @escaping @Sendable (String) async throws -> Mission,
        deleteMissions: @escaping @Sendable (String) async throws -> Mission
    ) {
        self.getMissions = getMissions
        self.deleteMissions = deleteMissions
    }
}
