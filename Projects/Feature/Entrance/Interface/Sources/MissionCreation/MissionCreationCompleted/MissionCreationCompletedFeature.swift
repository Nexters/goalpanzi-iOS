//
//  MissionCreationCompletedFeature.swift
//  FeatureEntranceInterface
//
//  Created by Miro on 8/8/24.
//

import Foundation

import ComposableArchitecture


@Reducer
public struct MissionCreationCompletedFeature: Reducer {

    public init() {}

    @ObservableState
    public struct State: Equatable {}

    public enum Action: Equatable {
        case startButtonTapped
        
        public enum Delegate {
            case didStartButtonTapped
        }
        
        case delegate(Delegate)
    }

    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .startButtonTapped:
                return .run { send in
                    await send(.delegate(.didStartButtonTapped))
                }
            default:
                return .none
            }
        }
    }
}
