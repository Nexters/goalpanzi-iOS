//
//  UserClient.swift
//  DomainUserInterface
//
//  Created by Haeseok Lee on 7/26/24.
//

// 일단 import Piece를 Domain에 넣어두기
import UIKit

import ComposableArchitecture
import SharedDesignSystem

public enum Piece: String, CaseIterable {
     
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

    public var roundImage: UIImage {
        switch self {
        case .rabbit: SharedDesignSystemAsset.Images.basicRoundRabbit.image
        case .cat: SharedDesignSystemAsset.Images.basicRoundCat.image
        case .dog: SharedDesignSystemAsset.Images.basicRoundPuppy.image
        case .bird: SharedDesignSystemAsset.Images.basicRoundBird.image
        case .panda: SharedDesignSystemAsset.Images.basicRoundPanda.image
        case .bear: SharedDesignSystemAsset.Images.basicRoundBear.image
        }
    }
    
    public var basicImage: UIImage {
        switch self {
        case .rabbit: SharedDesignSystemAsset.Images.basicRabbit.image
        case .cat: SharedDesignSystemAsset.Images.basicCat.image
        case .dog: SharedDesignSystemAsset.Images.basicPuppy.image
        case .bird: SharedDesignSystemAsset.Images.basicBird.image
        case .panda: SharedDesignSystemAsset.Images.basicPanda.image
        case .bear: SharedDesignSystemAsset.Images.basicBear.image
        }
    }
}

public struct UserClient {
    
    typealias NickName = String
    
    public var createProfile: @Sendable (_ nickName: String, Piece) async throws -> Void
    
    public init(createProfile: @escaping @Sendable (_ nickName: String, Piece) -> Void) {
        self.createProfile = createProfile
    }
    
}
