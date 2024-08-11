//
//  MissionDurationSettingView.swift
//  FeatureEntrance
//
//  Created by 김용재 on 8/7/24.
//

import SwiftUI

import DomainMissionInterface
import SharedDesignSystem
import SharedUtil

import ComposableArchitecture

public struct MissionDurationSettingView: View {

    @Bindable public var store: StoreOf<MissionDurationSettingFeature>

    public init(store: StoreOf<MissionDurationSettingFeature>) {
        self.store = store
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            MMNavigationBar(
                title: "기간 및 요일 설정",
                navigationAccessoryItem: AnyView(MMCapsuleTagView(
                    text: "2/3",
                    font: .pretendard(kind: .body_xl, type: .medium),
                    horizontalPadding: 14,
                    verticalPadding: 1
                ))
            ) {
                store.send(.backButtonTapped)
            }
            .padding(.bottom, 22)

            authenticationDaysHeaderView
                .padding(.bottom, 60)

            Text("미션")
                .foregroundStyle(Color.mmGray2)
                .font(.pretendard(kind: .body_md, type: .bold))
                .padding(.bottom, 8)

            HStack {
                DateSelectionButton(
                    date: $store.missionStartDate,
                    minimumDate: .constant(store.startMinimumDate),
                    isEnabled: .constant(true),
                    placeHolder: "시작일"
                )
                .onChange(of: store.missionStartDate, { oldValue, newValue in
                    store.isStartDateSelected = true
                    store.endMinimumDate = Calendar.current.date(byAdding: .day, value: 2, to: store.missionStartDate ?? Date()) ?? Date()
                })
                Text("~")
                DateSelectionButton(
                    date: $store.missionEndDate,
                    minimumDate: $store.endMinimumDate,
                    isEnabled: $store.isStartDateSelected,
                    placeHolder: "마감일"
                )
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 8)

            Text("내일부터 시작일로 지정할 수 있어요.")
                .font(.pretendard(size: 14, type: .light))
                .foregroundStyle(Color.mmGray3)
                .padding(.bottom, 40)

            VStack(alignment: .leading, spacing: 10) {
                Text("인증 요일 (다중선택)")
                    .font(.pretendard(kind: .body_md, type: .bold))
                    .foregroundStyle(store.isSelectWeekDayEnabled ? Color.mmGray2 : Color.mmGray2.opacity(0.3))

                HStack {
                    ForEach(Weekday.allCases, id: \.self) { day in
                        DaySelectionButton(
                            day: day.koreanName,
                            isSelected: store.selectedDays.contains(day),
                            isEnabled: store.missionEndDate != nil
                        ) {
                            if store.selectedDays.contains(day) {
                                store.selectedDays.remove(day)
                            } else {
                                store.selectedDays.insert(day)
                            }
                            store.send(.daySelectionButtonTapped)
                        }
                    }
                }

                Text("선택한 요일에만 미션 인증할 수 있어요.(ex.월,수,금)")
                    .font(.pretendard(size: 14, type: .light))
                    .foregroundStyle(store.isSelectWeekDayEnabled ? Color.mmGray2 : Color.mmGray2.opacity(0.3))
            }

            Spacer()

            MMRoundedButton(isEnabled: $store.isAllCompleted, title: "다음") {
                store.send(.nextButtonTapped)
            }
            .frame(height: 60)
            .padding(.bottom, 36)
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .padding(.horizontal, 24)
    }
}

extension MissionDurationSettingView {

    // TODO: 아래 attributed text로 하는 방법으로 바꾸기 (재사용가능하게)
    var authenticationDaysHeaderView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                Text("경쟁 기간")
                    .foregroundStyle(Color.mmOrange)
                Text("내 ")
                Text("인증 요일")
                    .foregroundStyle(Color.mmOrange)
                Text("로 계산한")
            }
            .font(.pretendard(kind: .title_xl, type: .light))

            HStack(alignment: .top, spacing: 0) {
                Text("총 인증 횟수는 ")
                Text("\(String(format: "%02d", store.authenticationDays))번")
                    .bold()
                    .underline()
                Text(" 이에요!")
            }
            .font(.pretendard(kind: .title_xl, type: .light))
        }
    }
}
