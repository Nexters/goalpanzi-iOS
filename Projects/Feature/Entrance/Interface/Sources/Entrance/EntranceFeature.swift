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

        public init() {}
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
                state.path.append(.missionContentSetting(MissionContentSettingFeature.State()))
                return .none
            case .enterInvitationCodeButtonTapped:
                state.path.append(.missionInputInviationCode(MissionInvitationCodeFeature.State()))
                return .none
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}
