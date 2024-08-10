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
        @Presents var missionCreationCompleted: MissionCreationCompletedFeature.State?
        @Shared var missionCreationData: MissionCreationData
        
        var selectedTimeOfDay: TimeOfDay? = nil
        var isAllCompleted: Bool = false
        
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case completeButtonTapped
        
        case backButtonTapped
        case startMission
        
        // MARK: Child Action
        case missionCreationCompleted(PresentationAction<MissionCreationCompletedFeature.Action>)
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
                // TODO: 여기서 API 호출!
                state.missionCreationCompleted = MissionCreationCompletedFeature.State()
                return .none
            case .backButtonTapped:
                return .run { _ in
                  await self.dismiss()
                }
            case .missionCreationCompleted(.presented(.delegate(.didStartButtonTapped))):
                return .run { send in
                    await send(.startMission)
                }
            case .startMission:
                return .none
            default:
                return .none
            }
        }
        .ifLet(\.$missionCreationCompleted, action: \.missionCreationCompleted) {
          MissionCreationCompletedFeature()
        }
    }
}
