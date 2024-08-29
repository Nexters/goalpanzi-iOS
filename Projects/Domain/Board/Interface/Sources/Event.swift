//
//  Event.swift
//  DomainBoardInterface
//
//  Created by Haeseok Lee on 8/1/24.
//

import Foundation
import SharedDesignSystem

public enum Event {
    case reward((any RewardInfo)?)
    
    var position: Position? {
        switch self {
        case let .reward(info):
            return info?.position
        }
    }
}

public protocol RewardInfo: CustomStringConvertible {
    
    var position: Position { get }
    
    var resultImageAsset: SharedDesignSystemImages { get }
}
