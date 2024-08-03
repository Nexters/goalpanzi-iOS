//
//  JejuIslandBoardTheme.swift
//  DomainBoardInterface
//
//  Created by Haeseok Lee on 7/31/24.
//

import Foundation
import SharedDesignSystem

public struct JejuIslandBoardTheme: BoardTheme {
    
    public let blockTheme: any BlockTheme
    
    public var backgroundImageAsset: SharedDesignSystemImages {
        SharedDesignSystemAsset.Images.jejuBackground
    }
    
    public init(blockTheme: JejuIslandBlockTheme = .init()) {
        self.blockTheme = blockTheme
    }
    

public struct JejuIslandBlockTheme: BlockTheme {
    
    public init() {}
    
    public func conqueredImageAsset(kind: BlockKind) -> SharedDesignSystemImages {
        switch kind {
        case .square:
            return SharedDesignSystemAsset.Images.jejuMid
        case .firstQuadrant:
            return SharedDesignSystemAsset.Images.jejuRightUp
        case .secondQuadrant:
            return SharedDesignSystemAsset.Images.jejuLeftUp
        case .thirdQuadrant:
            return SharedDesignSystemAsset.Images.jejuLeftDown
        case .fourthQuardrant:
            return SharedDesignSystemAsset.Images.jejuRightDown
        }
    }
}
}
