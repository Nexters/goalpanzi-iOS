//
//  MissionDurationSettingFeature.swift
//  FeatureEntrance
//
//  Created by 김용재 on 8/7/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct MissionDurationSettingFeature: Reducer {

    public init() {}

    @ObservableState
    public struct State: Equatable {

        var missionStartDate: Date? = nil
        var missionEndDate: Date? = nil

        var startMinimumDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
        var endMinimumDate = Date()
        
        var selectedDays: Set<Weekday> = []
        var authenticationDays: Int = 0

        public init() {}
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case daySelectionButtonTapped
    }

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce<State, Action> { state, action in
            switch action {
            case .binding(\.missionStartDate):
                updateAuthenticationDays(with: &state)
                return .none
            case .binding(\.missionEndDate):
                updateAuthenticationDays(with: &state)
                return .none
            case .daySelectionButtonTapped:
                updateAuthenticationDays(with: &state)
                return .none
            default:
                return .none
            }
        }
    }
}

extension MissionDurationSettingFeature {

    private func updateAuthenticationDays(with state: inout State) {
        let days = calculateAuthenticationDays(from: state)
        state.authenticationDays = days
    }

    private func calculateAuthenticationDays(from state: State) -> Int {
        let calendar = Calendar.current
        guard let startDate = state.missionStartDate else { return 0 }
        guard let endDate = state.missionEndDate else { return 0 }

        var currentDate = startDate

        var authenticationDayCount = 0

        while currentDate <= endDate {
            let weekday = calendar.component(.weekday, from: currentDate)
            let weekdayEnum: Weekday

            switch weekday {
            case 1: weekdayEnum = .sunday
            case 2: weekdayEnum = .monday
            case 3: weekdayEnum = .tuesday
            case 4: weekdayEnum = .wednesday
            case 5: weekdayEnum = .thursday
            case 6: weekdayEnum = .friday
            case 7: weekdayEnum = .saturday
            default: continue
            }
            if state.selectedDays.contains(weekdayEnum) {
                authenticationDayCount += 1
            }

            guard let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) else {
                break
            }
            currentDate = nextDate
        }

        return authenticationDayCount
    }
}

