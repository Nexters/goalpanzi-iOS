//
//  EntranceFeature.swift
//  FeatureEntranceInterface
//
//  Created by Miro on 8/5/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct EntranceFeature: Reducer {
    
    public init() {}
    
    @Reducer
    public enum Path {
        case missionContentSetting(MissionContentSettingFeature)
        case missionDurationSetting(MissionDurationSettingFeature)
        case missionAuthTimeSetting(MissionAuthTimeSettingFeature)
        case missionInputInviationCode(MissionInvitationCodeFeature)
    }
    
    @ObservableState
    public struct State {
        
        var path = StackState<Path.State>()
        @Shared var missionCreationData: MissionCreationData
        
        public init() {
            self._missionCreationData = Shared(MissionCreationData())
        }
    }
    
    public enum Action {
        case path(StackActionOf<Path>)

        case createMissionButtonTapped
        case enterInvitationCodeButtonTapped
    }
    
    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .createMissionButtonTapped:
                state.path.append(.missionContentSetting(MissionContentSettingFeature.State( missionCreationData: state.$missionCreationData)))
                return .none
//                state.path.append(.missionContentSetting(MissionContentSettingFeature.State(missionCreationData: state.$missionCreationData)))
            case .enterInvitationCodeButtonTapped:
//                state.path.append(.missionInputInviationCode(MissionInvitationCodeFeature.State()))
                return .none
            case let .path(action):
                switch action {
                case .element(id: _, action: .missionContentSetting(.nextButtonTapped)):
                    state.path.append(.missionDurationSetting(MissionDurationSettingFeature.State(missionCreationData: state.$missionCreationData)))
                    return .none
                case .element(id: _, action: .missionDurationSetting(.nextButtonTapped)):
                    state.path.append(.missionAuthTimeSetting(MissionAuthTimeSettingFeature.State(missionCreationData: state.$missionCreationData)))
                    return .none
                case .element(id: _, action: .missionAuthTimeSetting(.completeButtonTapped)):
//                    state.path.append(.missionAuthTimeSetting(MissionAuthTimeSettingFeature.State(missionCreationData: state.$missionCreationData)))
                    return .none
                default:
                    return .none
                }
            }
        }
        .forEach(\.path, action: \.path)
    }
}
