//
//  MissionServiceable.swift
//  Domain
//
//  Created by Haeseok Lee on 8/11/24.
//

import Foundation

public protocol MissionServiceable {
    
    var getMissions: @Sendable (_ missionId: String) async throws -> Mission { get }
    
    var deleteMissions: @Sendable (_ missionId: String) async throws -> Mission { get }
}
