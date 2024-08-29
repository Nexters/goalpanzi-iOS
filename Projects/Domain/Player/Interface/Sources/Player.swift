//
//  Player.swift
//  DomainPlayerInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

import Foundation
import SharedDesignSystem
import DomainBoardInterface
import DomainUserInterface

public typealias PlayerID = String

public struct Player: Identifiable {
    
    public let id: PlayerID
    
    public let pieceID: PieceID
    
    public let name: String
    
    public let character: DomainUserInterface.Character
    
    public let isMe: Bool
    
    public init(
        id: PlayerID,
        pieceID: PieceID,
        name: String,
        character: DomainUserInterface.Character,
        isMe: Bool = false
    ) {
        self.id = id
        self.pieceID = pieceID
        self.name = name
        self.character = character
        self.isMe = isMe
    }
}
