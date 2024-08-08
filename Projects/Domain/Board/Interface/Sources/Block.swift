//
//  Block.swift
//  DomainBoardInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

import Foundation

public struct Block {

    public let position: Position
    
    public let theme: any BlockTheme
    
    public let kind: BlockKind
    
    public var isStartBlock: Bool {
        position == .zero
    }
    
    public let isLastBlock: Bool
    
    public var isConquered: Bool
    
    public let isDisabled: Bool
    
    public init(
        position: Position,
        kind: BlockKind,
        theme: any BlockTheme,
        isLastBlock: Bool = false,
        isConquered: Bool = false,
        isDisabled: Bool = false
    ) {
        self.position = position
        self.kind = kind
        self.theme = theme
        self.isLastBlock = isLastBlock
        self.isConquered = isConquered
        self.isDisabled = isDisabled
    }
}
