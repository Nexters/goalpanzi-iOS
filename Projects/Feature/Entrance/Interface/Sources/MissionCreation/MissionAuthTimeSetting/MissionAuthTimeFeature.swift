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
        
        @Shared var missionCreationData: MissionCreationData
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case completeButtonTapped
        case backButtonTapped
    }

    @Dependency(\.dismiss) var dismiss

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce<State, Action> { state, action in
            switch action {
            case .binding(\.selectedTimeOfDay):
                state.isAllCompleted = true
                return .none
            case .completeButtonTapped:
                state.missionCreationData.timeOfDay = state.selectedTimeOfDay ?? .morning
                return .none
            case .backButtonTapped:
                return .run { _ in
                  await self.dismiss()
                }
            default:
                return .none
            }
        }
    }
}
