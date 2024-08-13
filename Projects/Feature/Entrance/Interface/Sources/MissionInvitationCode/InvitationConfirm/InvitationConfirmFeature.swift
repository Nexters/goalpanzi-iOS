//
//  InvitationConfirmFeature.swift
//  FeatureEntrance
//
//  Created by 김용재 on 8/9/24.
//

import Foundation

import DomainMissionInterface

import ComposableArchitecture

@Reducer
public struct InvitationConfirmFeature: Reducer {

    public init() {}

    @ObservableState
    public struct State: Equatable {
        var mission: Mission
        var authenticationDays: String
        var missionTitle: String
        var missionDuration: String
        var missionWeekDay: String
        var missionTimeOfDay: String

        public init(mission: Mission) {
            self.mission = mission
            self.authenticationDays = "\(mission.authenticationDays)"
            self.missionTitle = mission.description
            self.missionDuration = mission.startDate.formattedString(dateFormat: .yearMonthDate) + "~" + mission.endDate.formattedString(dateFormat: .yearMonthDate)
            self.missionWeekDay = mission.authenticationWeekDays.map { $0.koreanName }.joined(separator: "/")
            self.missionTimeOfDay = mission.timeOfDay.description
        }
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
