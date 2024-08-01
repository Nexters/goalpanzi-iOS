//
//  BoardTheme.swift
//  DomainBoardInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

import Foundation

public protocol BoardTheme {
    
    var backgroundImageName: String { get }
    
    func normalBlockImageName(kind: BlockKind) -> String
    
    func conqueredBlockImageName(kind: BlockKind) -> String
}

public extension BoardTheme {
    
    func normalBlockImageName(kind: BlockKind) -> String {
        switch kind {
        case .square:
            return ""
        case .firstQuadrant:
            return ""
        case .secondQuadrant:
            return ""
        case .thirdQuadrant:
            return ""
        case .fourthQuardrant:
            return ""
        }
    }
}
