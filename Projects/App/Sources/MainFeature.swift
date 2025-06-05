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
import FeatureEntranceInterface

@Reducer
struct MainFeature {
    
    @ObservableState
    struct State {
        var entranceState: EntranceFeature.State? = EntranceFeature.State(isFirstEntrance: false)
        var homeState: HomeFeature.State? = HomeFeature.State()
        var myHistoryState: MyHistoryFeature.State? = MyHistoryFeature.State()
        var settingState: SettingFeature.State? = SettingFeature.State()
        var focusedTab: TabKind
        var tabs: [TabKind]
        
        init(focusedTab: TabKind = .inprogressMission(.home)) {
            self.focusedTab = focusedTab
            switch focusedTab {
            case .inprogressMission(.home):
                tabs = [.inprogressMission(.home), .myHistory, .setting]
                
            case let .inprogressMission(.entrance(isFirstEntrance)):
                tabs = [.inprogressMission(.entrance(isFirstEntrance: isFirstEntrance)), .myHistory, .setting]
                
            case .myHistory:
                tabs = [.inprogressMission(.home), .myHistory, .setting]
                
            case .setting:
                tabs = [.inprogressMission(.home), .myHistory, .setting]
            }
        }
        
        mutating func update(isFirstEntrance: Bool) {
            self.entranceState?.update(isFirstEntrance: isFirstEntrance)
        }
    }
    
    enum Action {
        case didLoad
        case entrance(EntranceFeature.Action)
        case home(HomeFeature.Action)
        case myHistory(MyHistoryFeature.Action)
        case setting(SettingFeature.Action)
        case didTapTab(TabKind)
        case delegate(Delegate)
    }
    
    enum TabKind {
        case inprogressMission(HomeTabKind)
        case myHistory
        case setting
    }
    
    enum HomeTabKind {
        case home
        case entrance(isFirstEntrance: Bool)
    }
    
    enum Delegate {
        case didEndMission
        case didEndLogin
        case didCreateMission
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
                
            case let .didTapTab(tab):
                state.focusedTab = tab
                return .none
                
            case .entrance(.delegate(.didCreateMission)):
                return .send(.delegate(.didCreateMission))
                
            case .entrance:
                return .none
                
            case .home:
                return .none

            case .myHistory:
                return .none
                
            case .setting:
                return .none
                
            case .delegate:
                return .none
            }
        }
        .ifLet(\.entranceState, action: \.entrance) {
            EntranceFeature()
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
