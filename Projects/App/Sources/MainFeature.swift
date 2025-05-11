//
//  MainFeature.swift
//  MissionMate
//
//  Created by Haeseok Lee on 5/11/25.
//

import Foundation
import ComposableArchitecture
import FeatureHomeInterface
import FeatureSettingInterface

@Reducer
struct MainFeature {
    
    @ObservableState
    struct State {
        var homeState: HomeFeature.State? = HomeFeature.State()
        var myHistoryState: MyHistoryFeature.State? = MyHistoryFeature.State()
        var settingState: SettingFeature.State? = SettingFeature.State()
        var focusedTab: TabKind = .home
    }
    
    enum Action {
        case didLoad
        case home(HomeFeature.Action)
        case myHistory(MyHistoryFeature.Action)
        case setting(SettingFeature.Action)
        case didTapTab(TabKind)
        case delegate(Delegate)
    }
    
    enum TabKind {
        case home
        case myHistory
        case setting
    }
    
    enum Delegate {
        case didEndMission
        case didEndLogin
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didLoad:
                return .none
            
            case .home(.delegate(.didFinishMission)),
                 .home(.delegate(.didDeleteMission)):
                return .send(.delegate(.didEndMission))
            
            case .home(.delegate(.didLogout)),
                 .home(.delegate(.didDeleteProfile)):
                return .send(.delegate(.didEndLogin))
                
            case .myHistory:
                return .none
                
            case .setting:
                
                return .none
                
            case let .didTapTab(tab):
                state.focusedTab = tab
                return .none
                
            case .home(_):
                return .none
                
            case .delegate:
                return .none
            }
        }
        .ifLet(\.homeState, action: \.home) {
            HomeFeature()
        }
        .ifLet(\.myHistoryState, action: \.myHistory) {
            MyHistoryFeature()
        }
        .ifLet(\.settingState, action: \.setting) {
            SettingFeature()
        }
    }
}
