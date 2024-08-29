//
//  MissionAuthTimeSettingFeature.swift
//  FeatureEntrance
//
//  Created by Miro on 8/7/24.
//

import Foundation

import DomainMissionInterface
import DomainMission
import DataRemote
import DataRemoteInterface

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
        var isCreationMissionLoading = false
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case completeButtonTapped
        
        case backButtonTapped
        case startMission
        case createMissionResponse(Result<(MissionID, InvitationCode), Error>)
        
        // MARK: Child Action
        case missionCreationCompleted(PresentationAction<MissionCreationCompletedFeature.Action>)
    }

    @Dependency(\.dismiss) var dismiss
    @Dependency(MissionClient.self) var missionClient
    @Dependency(MissionService.self) var missionService

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce<State, Action> { state, action in
            switch action {

            case .binding(\.selectedTimeOfDay):
                state.isAllCompleted = true
                return .none
            case .binding:
                return .none
            case .completeButtonTapped:
                state.isCreationMissionLoading = true
                state.missionCreationData.timeOfDay = state.selectedTimeOfDay ?? .morning
                
                return .run { [data = state.missionCreationData] send in
                    await send(.createMissionResponse(
                        Result { try await self.missionClient.createMission(
                            missionService,
                            data.description,
                            data.startDate,
                            data.endDate,
                            data.timeOfDay,
                            data.verificationWeekDays,
                            data.verificationDays
                        )}
                    ))
                }
                
            case let .createMissionResponse(.success(response)):
                print(response)
                state.isCreationMissionLoading = false
                state.missionCreationCompleted = MissionCreationCompletedFeature.State()
                return .none
            case let .createMissionResponse(.failure(error)):
                state.isCreationMissionLoading = false
                print("🚨 미션 생성 Error 발생 - \(error)")
                return .none
                
            case .backButtonTapped:
                return .run { _ in
                  await self.dismiss()
                }
            case .missionCreationCompleted(.presented(.delegate(.didStartButtonTapped))):
                return .send(.startMission)
            case .startMission:
                return .none
            case .missionCreationCompleted(.dismiss):
                return .none
            case .missionCreationCompleted(.presented(.startButtonTapped)):
                return .none
            }
        }
        .ifLet(\.$missionCreationCompleted, action: \.missionCreationCompleted) {
          MissionCreationCompletedFeature()
        }
    }
}
