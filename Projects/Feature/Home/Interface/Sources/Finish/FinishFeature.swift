//
//  FinishFeature.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/13/24.
//

import Foundation
import DomainPlayerInterface
import ComposableArchitecture

@Reducer
public struct FinishFeature {
    
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    public struct State {
        
        public let missionId: Int
        
        public let player: Player
        
        public let rank: Int
        
        public init(missionId: Int, player: Player, rank: Int) {
            self.missionId = missionId
            self.player = player
            self.rank = rank
        }
    }
    
    public enum Action {
        case didTapConfirmButton
        case didTapSettingButton
        case delegate(Delegate)
    }
    
    public enum Delegate {
        case didTapConfirmButton
        case didTapSettingButton
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapConfirmButton:
                return .concatenate(
                    .run { _ in
                        await self.dismiss()
                    },
                    .send(.delegate(.didTapConfirmButton))
                )
            case .didTapSettingButton:
                return .send(.delegate(.didTapSettingButton))
            case .delegate:
                return .none
            }
        }
    }
    
    public init() {}
}
