//
//  MissionDurationSettingView.swift
//  FeatureEntrance
//
//  Created by 김용재 on 8/7/24.
//

import SwiftUI

import SharedDesignSystem
import SharedUtil

import ComposableArchitecture

public struct MissionDurationSettingView: View {

    @Bindable public var store: StoreOf<MissionDurationSettingFeature>

    public init(store: StoreOf<MissionDurationSettingFeature>) {
        self.store = store
    }

    @State private var isStartDateSelected = false


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
                print("backButtonTapped")
            }

            authenticationDaysView

            Text("미션")
                .foregroundStyle(Color.mmGray2)
                .font(.pretendard(kind: .body_md, type: .bold))

            HStack {
                DateSelectionButton(
                    date: $store.missionStartDate,
                    minimumDate: .constant(store.startMinimumDate),
                    isEnabled: .constant(true),
                    placeHolder: "시작일"
                )
                .onChange(of: store.missionStartDate, { oldValue, newValue in
                    isStartDateSelected = true
                    store.endMinimumDate = Calendar.current.date(byAdding: .day, value: 2, to: store.missionStartDate ?? Date()) ?? Date()
                })
                Text("~")
                DateSelectionButton(
                    date: $store.missionEndDate,
                    minimumDate: $store.endMinimumDate,
                    isEnabled: $isStartDateSelected,
                    placeHolder: "마감일"
                )
            }
            .frame(maxWidth: .infinity)

            Text("내일부터 시작일로 지정할 수 있어요.")
                .font(.pretendard(size: 14, type: .medium))
                .foregroundColor(.mmGray3)

            VStack(alignment: .leading, spacing: 10) {
                Text("인증 요일 (다중선택)")
                    .font(.pretendard(kind: .body_md, type: .bold))
                    .foregroundStyle(Color.mmGray2)

                HStack {
                    ForEach(Weekday.allCases, id: \.self) { day in
                        DaySelectionButton(
                            day: day,
                            isSelected: store.selectedDays.contains(day),
                            isAnySelected: !store.selectedDays.isEmpty
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
                    .font(.pretendard(size: 14, type: .medium))
                    .foregroundStyle(Color.mmGray2)
            }

            Spacer()

            MMRoundedButton(isEnabled: .constant(true), title: "다음") {
            }
            .frame(height: 60)
            .padding(.bottom, 36)
        }
        .edgesIgnoringSafeArea(.bottom)
        .padding(.horizontal, 24)
    }
}

extension MissionDurationSettingView {
    var authenticationDaysView: some View {
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
