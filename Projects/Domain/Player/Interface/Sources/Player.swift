//
//  Player.swift
//  DomainPlayerInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

import Foundation
import SharedDesignSystem
import DomainBoardInterface

public typealias PlayerID = String

public struct Player: Identifiable {
    
    public let id: PlayerID
    
    public var pieceID: PieceID
    
    public let name: String
    
    public let character: PlayerCharacter
    
    public var isMe: Bool
    
    public var isCertificated: Bool
    
    public init(
        id: PlayerID,
        pieceID: PieceID,
        name: String,
        character: PlayerCharacter,
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
}

public enum PlayerCharacter {
    
    case rabbit
    
    public var imageAsset: SharedDesignSystemImages {
        switch self {
        case .rabbit:
            return SharedDesignSystemAsset.Images.jejuMid
        }
    }
}
