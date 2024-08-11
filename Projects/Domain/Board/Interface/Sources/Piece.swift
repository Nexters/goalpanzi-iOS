//
//  Piece.swift
//  DomainBoardInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

import Foundation
import SharedDesignSystem

public typealias PieceID = String

public struct Piece: Identifiable, Hashable {
    
    public let id: PieceID
    
    public let position: Position
    
    public let image: SharedDesignSystemImages
    
    public let name: String
    
    public let isHighlighted: Bool
    
    public init(
        id: PieceID,
        position: Position,
        image: SharedDesignSystemImages,
        name: String,
        isHighlighted: Bool
    ) {
        self.id = id
        self.position = position
        self.image = image
        self.name = name
        self.isHighlighted = isHighlighted
    }
    
    public static func == (lhs: Piece, rhs: Piece) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(position)
    }
    
}
