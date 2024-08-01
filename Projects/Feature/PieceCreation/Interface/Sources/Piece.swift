//
//  Piece.swift
//  FeaturePieceCreationInterface
//
//  Created by 김용재 on 7/30/24.
//

import SwiftUI
import SharedDesignSystem

public enum Piece: CaseIterable {
    
    case rabbit
    case cat
    case puppy
    case bird
    case panda
    case bear
    
    public var koreanName: String {
        switch self {
        case .rabbit: "뚝심토끼"
        case .cat: "포기란없다냥"
        case .puppy: "끝까지해볼개"
        case .bird: "할때까지해뱁새"
        case .panda: "하나만팬다"
        case .bear: "할건끝내곰"
        }
    }

    public var roundImage: UIImage {
        switch self {
        case .rabbit: SharedDesignSystemAsset.Images.basicRoundRabbit.image
        case .cat: SharedDesignSystemAsset.Images.basicRoundCat.image
        case .puppy: SharedDesignSystemAsset.Images.basicRoundPuppy.image
        case .bird: SharedDesignSystemAsset.Images.basicRoundBird.image
        case .panda: SharedDesignSystemAsset.Images.basicRoundPanda.image
        case .bear: SharedDesignSystemAsset.Images.basicRoundBear.image
        }
    }
    
    public var basicImage: UIImage {
        switch self {
        case .rabbit: SharedDesignSystemAsset.Images.basicRabbit.image
        case .cat: SharedDesignSystemAsset.Images.basicCat.image
        case .puppy: SharedDesignSystemAsset.Images.basicPuppy.image
        case .bird: SharedDesignSystemAsset.Images.basicBird.image
        case .panda: SharedDesignSystemAsset.Images.basicPanda.image
        case .bear: SharedDesignSystemAsset.Images.basicBear.image
        }
    }
}
