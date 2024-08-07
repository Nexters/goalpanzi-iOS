//
//  MissionAuthTimeSettingFeature.swift
//  FeatureEntrance
//
//  Created by Miro on 8/7/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct MissionAuthTimeSettingFeature: Reducer {

    public init() {}

    @ObservableState
    public struct State: Equatable {
        var selectedTimeOfDay: TimeOfDay? = nil
        var isAllCompleted: Bool = false

        public init() {}
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case completeButtonTapped
    }

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce<State, Action> { state, action in
            switch action {
            case .binding(\.selectedTimeOfDay):
                state.isAllCompleted = true
                return .none
            case .completeButtonTapped:
                return .none
            default:
                return .none
            }
        }
    }
}
