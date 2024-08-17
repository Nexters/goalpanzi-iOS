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
    
    public var pieceID: PieceID
    
    public let name: String
    
    public let character: DomainUserInterface.Character
    
    public var isMe: Bool
    
    public var isCertificated: Bool
    
    public init(
        id: PlayerID,
        pieceID: PieceID,
        name: String,
        character: DomainUserInterface.Character,
        isMe: Bool = false,
        isCertificated: Bool = false
    ) {
        self.id = id
        self.pieceID = pieceID
        self.name = name
        self.character = character
        self.isMe = isMe
        self.isCertificated = isCertificated
    }
    
    public mutating func update(isCertificated: Bool) {
        self.isCertificated = isCertificated
    }
}
