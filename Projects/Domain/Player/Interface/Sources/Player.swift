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
    
    public let name: String
    
    public let characterImageName: String
    
    public var isMe: Bool
    
    public init(
        id: PlayerID,
        pieceID: PieceID,
        name: String,
        characterImageName: String,
        isMe: Bool = false
    ) {
        self.id = id
        self.pieceID = pieceID
        self.name = name
        self.characterImageName = characterImageName
        self.isMe = isMe
    }
}
