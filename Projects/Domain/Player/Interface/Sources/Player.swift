//
//  Player.swift
//  DomainPlayerInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

import Foundation
import DomainBoardInterface

public typealias PlayerID = String

public struct Player: Identifiable {
    
    public let id: PlayerID
    
    public var pieceID: PieceID
    
    public init(id: PlayerID, pieceID: PieceID) {
        self.id = id
        self.pieceID = pieceID
    }
}
