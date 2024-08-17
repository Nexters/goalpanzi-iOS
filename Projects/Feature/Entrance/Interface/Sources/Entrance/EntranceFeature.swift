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
        // 🚨 미션 생성
        case missionContentSetting(MissionContentSettingFeature)
        case missionDurationSetting(MissionDurationSettingFeature)
        case missionAuthTimeSetting(MissionAuthTimeSettingFeature)
        
        // 🚨 초대코드 검증
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
        case delegate(Delegate)
    }
    
    public enum Delegate {
        case didCreateMission
    }
    
    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .createMissionButtonTapped:
                state.path.append(.missionContentSetting(MissionContentSettingFeature.State( missionCreationData: state.$missionCreationData)))
                return .none
            case .enterInvitationCodeButtonTapped:
                state.path.append(.missionInputInviationCode(MissionInvitationCodeFeature.State()))
                return .none
            case let .path(action):
                switch action {
                case .element(id: _, action: .missionContentSetting(.nextButtonTapped)):
                    state.path.append(.missionDurationSetting(MissionDurationSettingFeature.State(missionCreationData: state.$missionCreationData)))
                    return .none
                case .element(id: _, action: .missionDurationSetting(.nextButtonTapped)):
                    state.path.append(.missionAuthTimeSetting(MissionAuthTimeSettingFeature.State(missionCreationData: state.$missionCreationData)))
                    return .none
                case .element(id: _, action: .missionAuthTimeSetting(.startMission)):
                    return .send(.delegate(.didCreateMission))
                case .element(id: _, action: .missionInputInviationCode(.startMission)):
                    return .send(.delegate(.didCreateMission))
                default:
                    return .none
                }
            case .delegate:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}
