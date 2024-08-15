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
    
    public func eventImageAsset(kind: BlockKind, event: DomainBoardInterface.Event) -> SharedDesignSystemImages? {
        guard case let .reward(info) = event, let jejuInfo = info as? JejuRewardInfo else { return nil }
        switch (kind, jejuInfo.kind) {
        case (.square, .orange):
            return SharedDesignSystemAsset.Images.jejuMidOrange
        case (.square, .beach):
            return SharedDesignSystemAsset.Images.jejuMidBeach
        case (.square, .sunrise):
            return SharedDesignSystemAsset.Images.jejuMidSunrise
        case (.square, .hallaMountain):
            return SharedDesignSystemAsset.Images.jejuMidHallaMountain
        case (.secondQuadrant, .waterfall):
            return SharedDesignSystemAsset.Images.jejuLeftUpWaterfall
        case (.secondQuadrant, .greenTeaField):
            return SharedDesignSystemAsset.Images.jejuLeftUpGreenTeaField
        case (.thirdQuadrant, .dolharubang):
            return SharedDesignSystemAsset.Images.jejuLeftDownDolharubang
        case (.fourthQuardrant, .blackPig):
            return SharedDesignSystemAsset.Images.jejuRightDownBlackPig
        case (.fourthQuardrant, .horseRiding):
            return SharedDesignSystemAsset.Images.jejuRightDownHorseRiding
        case (.fourthQuardrant, .canolaFlower):
            return SharedDesignSystemAsset.Images.jejuRightDownCanolaFlower
        default:
            return nil
        }
    }
}

public struct JejuRewardInfo: RewardInfo {
    
    public enum Kind: String {
        case orange = "ORANGE"
        case canolaFlower = "CANOLA_FLOWER"
        case dolharubang = "DOLHARUBANG"
        case horseRiding = "HORSE_RIDING"
        case hallaMountain = "HALLA_MOUNTAIN"
        case waterfall = "WATERFALL"
        case blackPig = "BLACK_PIG"
        case sunrise = "SUNRISE"
        case greenTeaField = "GREEN_TEA_FIELD"
        case beach = "BEACH"
    }
    
    public typealias RawValue = String
    
    public var kind: Kind
    
    public var position: Position
    
    public var description: String {
        switch kind {
        case .orange:
            return "감귤 먹기"
        case .canolaFlower:
            return "감귤 먹기"
        case .dolharubang:
            return "감귤 먹기"
        case .horseRiding:
            return "감귤 먹기"
        case .hallaMountain:
            return "감귤 먹기"
        case .waterfall:
            return "감귤 먹기"
        case .blackPig:
            return "감귤 먹기"
        case .sunrise:
            return "감귤 먹기"
        case .greenTeaField:
            return "감귤 먹기"
        case .beach:
            return "감귤 먹기"
        }
    }
    
    public var resultImageAsset: SharedDesignSystemImages {
        switch kind {
        case .orange:
            return SharedDesignSystemAsset.Images.rewardOrange
        case .canolaFlower:
            return SharedDesignSystemAsset.Images.rewardCanolaFlower
        case .dolharubang:
            return SharedDesignSystemAsset.Images.rewardDolharubang
        case .horseRiding:
            return SharedDesignSystemAsset.Images.rewardHorseRiding
        case .hallaMountain:
            return SharedDesignSystemAsset.Images.rewardHallaMountain
        case .waterfall:
            return SharedDesignSystemAsset.Images.rewardWaterfall
        case .blackPig:
            return SharedDesignSystemAsset.Images.rewardBlackPig
        case .sunrise:
            return SharedDesignSystemAsset.Images.rewardSunrise
        case .greenTeaField:
            return SharedDesignSystemAsset.Images.rewardGreenTeaField
        case .beach:
            return SharedDesignSystemAsset.Images.rewardBeach
        }
    }

    public init?(rawValue: RawValue?, position: Position) {
        guard let rawValue, let kind = Kind(rawValue: rawValue) else {
            return nil
        }
        self.kind = kind
        self.position = position
    }
}
