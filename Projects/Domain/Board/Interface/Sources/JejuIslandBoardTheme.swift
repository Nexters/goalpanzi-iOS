//
//  JejuIslandBoardTheme.swift
//  DomainBoardInterface
//
//  Created by Haeseok Lee on 7/31/24.
//

import Foundation

public struct JejuIslandBoardTheme: BoardTheme {
    
    public let backgroundImageName: String
    
    public init(backgroundImageName: String) {
        self.backgroundImageName = backgroundImageName
    }
    
    public func conqueredBlockImageName(kind: BlockKind) -> String {
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
