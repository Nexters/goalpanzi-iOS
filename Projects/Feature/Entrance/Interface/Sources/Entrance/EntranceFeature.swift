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
    
    @Reducer(state: .equatable)
    public enum Destination {
        case missionCreationSetting(MissionContentSettingFeature)
        case missionInvitationCode(MissionInvitationCodeFeature)
        
    }
    
    @ObservableState
    public struct State: Equatable {
        @Presents var destination: Destination.State?
        
        public init() {}
    }
    
    public enum Action {
        case destination(PresentationAction<Destination.Action>)
        
        case createMissionButtonTapped
        case enterInvitationCodeButtonTapped
        
    }
    
    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .createMissionButtonTapped:
                state.destination = .missionCreationSetting(MissionContentSettingFeature.State())
                return .none
            case .enterInvitationCodeButtonTapped:
                state.destination = .missionInvitationCode(MissionInvitationCodeFeature.State())
                return .none
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}
