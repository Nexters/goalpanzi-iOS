//
//  Mission.swift
//  DomainMissionInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

import Foundation
import DomainBoardInterface
import DomainCompetitionInterface

public struct Mission {
    
    public let competition: Competition
    
    public init(competition: Competition) {
        self.competition = competition
    }
}
