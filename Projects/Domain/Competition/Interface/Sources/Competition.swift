//
//  Competition.swift
//  DomainCompetitionInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

import Foundation
import DomainBoardInterface
import DomainPlayerInterface

public struct Competition {
    
    public var players: [Player]
    
    public var board: Board
    
    public init(players: [Player], board: Board) {
        self.players = players
        self.board = board
    }
}
