//
//  Character.swift
//  DomainUserInterface
//
//  Created by Miro on 8/2/24.
//

import Foundation

import SharedDesignSystem

public enum Character: String, CaseIterable {

    case rabbit = "RABBIT"
    case cat = "CAT"
    case dog = "DOG"
    case bird = "BIRD"
    case panda = "PANDA"
    case bear = "BEAR"

    public var koreanName: String {
        switch self {
        case .rabbit: "뚝심토끼"
        case .cat: "포기란없다냥"
        case .dog: "끝까지해볼개"
        case .bird: "할때까지해뱁새"
        case .panda: "하나만팬다"
        case .bear: "할건끝내곰"
        }
    }

    public var roundImage: SharedDesignSystemImages {
        switch self {
        case .rabbit: SharedDesignSystemAsset.Images.basicRoundRabbit
        case .cat: SharedDesignSystemAsset.Images.basicRoundCat
        case .dog: SharedDesignSystemAsset.Images.basicRoundPuppy
        case .bird: SharedDesignSystemAsset.Images.basicRoundBird
        case .panda: SharedDesignSystemAsset.Images.basicRoundPanda
        case .bear: SharedDesignSystemAsset.Images.basicRoundBear
        }
    }

    public var basicImage: SharedDesignSystemImages {
        switch self {
        case .rabbit: SharedDesignSystemAsset.Images.basicRabbit
        case .cat: SharedDesignSystemAsset.Images.basicCat
        case .dog: SharedDesignSystemAsset.Images.basicPuppy
        case .bird: SharedDesignSystemAsset.Images.basicBird
        case .panda: SharedDesignSystemAsset.Images.basicPanda
        case .bear: SharedDesignSystemAsset.Images.basicBear
        }
    }
}
