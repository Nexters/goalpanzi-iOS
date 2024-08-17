//
//  MissionContentSettingFeature.swift
//  FeatureEntrance
//
//  Created by Miro on 8/6/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct MissionContentSettingFeature: Reducer {

    public init() {}

    @ObservableState
    public struct State: Equatable {
        var inputMissionContent: String = ""
        var noticeMessage: String? = "4~12자 이내로 입력하세요. (0/12)"

        var isValidMission: Bool = true
        
        @Shared var missionCreationData: MissionCreationData
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case nextButtonTapped
        case backButtonTapped
    }
    
    @Dependency(\.dismiss) var dismiss

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce<State, Action> { state, action in
            switch action {
            case .binding(\.inputMissionContent):
                state.noticeMessage = "4~12자 이내로 입력하세요.  (\(state.inputMissionContent.count)/12)"
                state.isValidMission = self.validate(state.inputMissionContent)
                return .none
            case .nextButtonTapped:
                state.missionCreationData.description = state.inputMissionContent
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

extension MissionContentSettingFeature {

    private func validate(_ inputMissionContent: String) -> Bool {
        let contentLength = inputMissionContent.count
        return (contentLength >= 4 && contentLength <= 12) || contentLength == 0
    }
}
