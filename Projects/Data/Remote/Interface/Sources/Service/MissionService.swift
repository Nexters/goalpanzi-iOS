//
//  MissionService.swift
//  DataRemote
//
//  Created by Haeseok Lee on 8/11/24.
//

import Foundation
import DomainMissionInterface

public struct MissionService: MissionServiceable {
    
    public var getMissions: @Sendable (Int) async throws -> Mission
    
    public var deleteMissions: @Sendable (Int) async throws -> Mission
    
    public init(
        getMissions: @escaping @Sendable (Int) async throws -> Mission,
        deleteMissions: @escaping @Sendable (Int) async throws -> Mission
    ) {
        self.getMissions = getMissions
        self.deleteMissions = deleteMissions
    }
}
