//
//  InvitationConfirmFeature.swift
//  FeatureEntrance
//
//  Created by 김용재 on 8/9/24.
//

import Foundation


import ComposableArchitecture

@Reducer
public struct InvitationConfirmFeature: Reducer {

    public init() {}

    @ObservableState
    public struct State: Equatable {
        var authenticationDays: String = "12"
        var missionTitle = "매일 유산소 1시간"
        var missionDuration = "2024.07.24~2024.08.14"
        var missionWeekDay = "월/수/목"
        var missionTimeOfDay = "오전 00~12시"

        public init() {}
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        
        case confirmButtonTapped
        case denyButtonTapped
        
        public enum Delegate {
            case didConfirmButtonTapped
        }
        
        case delegate(Delegate)

    }
    
    @Dependency(\.dismiss) var dismiss
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce<State, Action> { state, action in
            switch action {
            case .confirmButtonTapped:
                return .run { send in
                    await send(.delegate(.didConfirmButtonTapped))
                }
            case .denyButtonTapped:
                return .run { _ in
                    await self.dismiss()
                }
            default:
                return .none
            }
        }
    }
}
