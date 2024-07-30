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
        case .bird: "하나만팬다"
        case .panda: "할건끝내곰"
        case .bear: "할때까지해뱁새"
        }
    }
    
    public var roundImage: UIImage {
        switch self {
        case .rabbit: SharedDesignSystemAsset.basicRoundRabbit.image
        case .cat: SharedDesignSystemAsset.basicRoundCat.image
        case .puppy: SharedDesignSystemAsset.basicRoundPuppy.image
        case .bird: SharedDesignSystemAsset.basicRoundBird.image
        case .panda: SharedDesignSystemAsset.basicRoundPanda.image
        case .bear: SharedDesignSystemAsset.basicRoundBear.image
        }
    }
    
    public var basicImage: UIImage {
        switch self {
        case .rabbit: SharedDesignSystemAsset.basicRabbit.image
        case .cat: SharedDesignSystemAsset.basicCat.image
        case .puppy: SharedDesignSystemAsset.basicPuppy.image
        case .bird: SharedDesignSystemAsset.basicBird.image
        case .panda: SharedDesignSystemAsset.basicPanda.image
        case .bear: SharedDesignSystemAsset.basicBear.image
        }
    }
    
    public var dimmedImage: UIImage {
        switch self {
        case .rabbit: SharedDesignSystemAsset.dimmedRabbit.image
        case .cat: SharedDesignSystemAsset.dimmedCat.image
        case .puppy: SharedDesignSystemAsset.dimmedPuppy.image
        case .bird: SharedDesignSystemAsset.dimmedBird.image
        case .panda: SharedDesignSystemAsset.dimmedPanda.image
        case .bear: SharedDesignSystemAsset.dimmedBear.image
        }
    }
}
