//
//  Piece.swift
//  DomainBoardInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

import Foundation

public typealias PieceID = String

public struct Piece: Identifiable, Hashable {
    
    public let id: PieceID
    
    public let position: Position
    
    public init(id: PieceID, position: Position) {
        self.id = id
        self.position = position
    }
}
