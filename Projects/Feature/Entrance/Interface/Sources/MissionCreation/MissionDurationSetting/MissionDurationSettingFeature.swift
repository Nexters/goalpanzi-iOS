//
//  MissionDurationSettingFeature.swift
//  FeatureEntrance
//
//  Created by 김용재 on 8/7/24.
//

import Foundation

import DomainMissionInterface

import ComposableArchitecture

@Reducer
public struct MissionDurationSettingFeature: Reducer {

    public init() {}

    @ObservableState
    public struct State: Equatable {
        var isStartDateSelected = false
        var isSelectWeekDayEnabled = false
        var isAllCompleted = false

        var missionStartDate: Date? = nil
        var missionEndDate: Date? = nil

        var startMinimumDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
        var endMinimumDate = Date()
        
        var selectedDays: Set<Weekday> = []
        var authenticationDays: Int = 0
        
        @Shared var missionCreationData: MissionCreationData
    }

    @Dependency(\.dismiss) var dismiss

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case daySelectionButtonTapped
        case nextButtonTapped
        case backButtonTapped
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
                state.isSelectWeekDayEnabled = true
                
                return .none
            case .daySelectionButtonTapped:
                updateAuthenticationDays(with: &state)
                state.isAllCompleted = (state.selectedDays.isEmpty || state.authenticationDays == 0) ? false : true
                
                return .none
            case .nextButtonTapped:
                state.missionCreationData.startDate = state.missionStartDate ?? Date()
                state.missionCreationData.endDate = state.missionEndDate ?? Date()
                state.missionCreationData.authenticationDays = state.authenticationDays
                state.missionCreationData.authenticationWeekDays = Array(state.selectedDays)
                
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
