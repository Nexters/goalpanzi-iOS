//
//  Position.swift
//  DomainBoardInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

import Foundation

public struct Position: Hashable {
    
    public static let zero: Self = .init(index: 0)
    
    public let index: Int
    
    public init(index: Int) {
        self.index = index
    }
}

public extension Position {
    
    static func + (lhs: Position, rhs: Position) -> Position {
        .init(index: lhs.index + rhs.index)
    }
    
    static func + (lhs: Position, rhs: Int) -> Position {
        .init(index: lhs.index + rhs)
    }
}
