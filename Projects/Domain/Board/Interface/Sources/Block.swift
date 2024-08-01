//
//  Block.swift
//  DomainBoardInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

import Foundation

public struct Block {

    public let position: Position
    
    public let theme: any BoardTheme
    
    public let event: [Event]
    
    public var isStartBlock: Bool {
        position == .zero
    }
    
    public var hasEvent: Bool {
        !event.isEmpty
    }
    
    public init(position: Position, theme: any BoardTheme, event: [Event]) {
        self.position = position
        self.theme = theme
        self.event = event
    }
    
    public func kind(numberOfColumns: Int, totalBlockCount: Int) -> BlockKind {
        
        if isStartBlock || position.index == totalBlockCount - 1 {
            return .square
        }
        
        let cycle: Int = (numberOfColumns * 2)
        guard cycle != .zero else { return .square }
        
        if position.index % cycle == numberOfColumns - 1 {
            return .firstQuadrant
        }
        
        if position.index % cycle == numberOfColumns {
            return .fourthQuardrant
        }
        
        if position.index % cycle == cycle - 1 {
            return .secondQuadrant
        }
        
        if position.index % cycle == .zero {
            return .thirdQuadrant
        }
        
        return .square
    }
}
