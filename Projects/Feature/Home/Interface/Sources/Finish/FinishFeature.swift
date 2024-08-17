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
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapConfirmButton:
                return .none
            case .didTapSettingButton:
                return .none
            }
        }
    }
    
    public init() {}
}
