//
//  Mission.swift
//  DomainMissionInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

import Foundation
import DomainBoardInterface
import DomainCompetitionInterface

public struct Mission: CustomStringConvertible {
    
    public let description: String
    
    public let competition: Competition
    
    public var board: Board { competition.board }
    
    public init(description: String, competition: Competition) {
        self.description = description
        self.competition = competition
    }
}
