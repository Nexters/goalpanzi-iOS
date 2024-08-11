//
//  MissionBoardService.swift
//  DataRemote
//
//  Created by Haeseok Lee on 8/11/24.
//

import Foundation
import DomainBoardInterface

public struct MissionBoardService: MissionBoardServiceable {
    
    public var getBoard: @Sendable (_ missionID: String) async throws -> MissionBoard
    
    public init(getBoard: @escaping @Sendable (_ missionID: String) async throws -> MissionBoard) {
        self.getBoard = getBoard
    }
}
