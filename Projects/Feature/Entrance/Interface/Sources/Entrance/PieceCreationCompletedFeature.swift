//
//  PieceCreationCompletedFeature.swift
//  FeatureEntranceInterface
//
//  Created by 김용재 on 8/20/24.
//

import Foundation

import DomainMissionInterface
import DomainUserInterface

import ComposableArchitecture

@Reducer
public struct PieceCreationCompletedFeature: Reducer {
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        var nickName: String
        var character: Character
        
        public init(nickName: String, character: Character) {
            self.nickName = nickName
            self.character = character
        }
    }
    
    @Dependency(\.dismiss) var dismiss
    
    public enum Action {
        case confirmButtonTapped
    }
    
    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .confirmButtonTapped:
                return .run { _ in
                    await self.dismiss()
                }
            }
        }
    }
}
