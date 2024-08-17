//
//  BoardTheme.swift
//  DomainBoardInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

import Foundation
import SharedDesignSystem

public protocol BoardTheme {
    
    var backgroundImageAsset: SharedDesignSystemImages { get }
    
    var blockTheme: any BlockTheme { get }
}

public protocol BlockTheme {
    
    var startImageAsset: SharedDesignSystemImages { get }
    
    func normalImageAsset(kind: BlockKind, isHighlighted: Bool) -> SharedDesignSystemImages
    
    func conqueredImageAsset(kind: BlockKind) -> SharedDesignSystemImages
    
    func eventImageAsset(kind: BlockKind, event: DomainBoardInterface.Event) -> SharedDesignSystemImages?
}

public extension BlockTheme {
    
    var startImageAsset: SharedDesignSystemImages {
        SharedDesignSystemAsset.Images.start
    }
    
    func normalImageAsset(kind: BlockKind, isHighlighted: Bool = false) -> SharedDesignSystemImages {
        switch (kind, isHighlighted) {
        case (.square, true):
            return SharedDesignSystemAsset.Images.midDisabled
        case (.square, false):
            return SharedDesignSystemAsset.Images.mid
        case (.firstQuadrant, true):
            return SharedDesignSystemAsset.Images.rightUpDisabled
        case (.firstQuadrant, false):
            return SharedDesignSystemAsset.Images.rightUp
        case (.secondQuadrant, true):
            return SharedDesignSystemAsset.Images.leftUpDisabled
        case (.secondQuadrant, false):
            return SharedDesignSystemAsset.Images.leftUp
        case (.thirdQuadrant, true):
            return SharedDesignSystemAsset.Images.leftDownDisabled
        case (.thirdQuadrant, false):
            return SharedDesignSystemAsset.Images.leftDown
        case (.fourthQuardrant, true):
            return SharedDesignSystemAsset.Images.rightDownDisabled
        case (.fourthQuardrant, false):
            return SharedDesignSystemAsset.Images.rightDown
        }
    }
}
