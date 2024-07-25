//
//  Board.swift
//  DomainBoardInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

import Foundation

public struct Board {
    
    public let theme: any BoardTheme
    
    public var blocks: [Block]
    
    public var pieces: Set<Piece>
    
    public init(theme: any BoardTheme, blocks: [Block], pieces: Set<Piece>) {
        self.theme = theme
        self.blocks = blocks
        self.pieces = pieces
    }
}
