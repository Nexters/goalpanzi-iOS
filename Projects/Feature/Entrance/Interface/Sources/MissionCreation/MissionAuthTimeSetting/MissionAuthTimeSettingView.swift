//
//  MissionAuthTimeSettingView.swift
//  FeatureEntrance
//
//  Created by Miro on 8/7/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct MissionAuthTimeSettingView: View {

    @Bindable public var store: StoreOf<MissionAuthTimeSettingFeature>

    public init(store: StoreOf<MissionAuthTimeSettingFeature>) {
        self.store = store
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            MMNavigationBar(
                title: "인증시간 설정",
                navigationAccessoryItem: AnyView(MMCapsuleTagView(
                    text: "3/3",
                    font: .pretendard(kind: .body_xl, type: .medium),
                    horizontalPadding: 14,
                    verticalPadding: 1
                ))
            ) {
                store.send(.backButtonTapped)
            }
            .padding(.bottom, 22)

            guidanceHeaderView
                .padding(.bottom, 60)

            Text("인증 시간")
                .foregroundStyle(Color.mmGray2)
                .font(.pretendard(kind: .body_md, type: .bold))
                .padding(.bottom, 8)

            HStack(spacing: 10) {
                ForEach(TimeOfDay.allCases, id: \.self) { time in
                    Button(action: {
                        store.selectedTimeOfDay = time
                    }) {
                        Text(time.description)
                            .frame(maxWidth: .infinity)
                            .frame(height: 84)
                            .background(store.selectedTimeOfDay == time ? Color.mmGray1 : Color.mmGray5)
                            .foregroundStyle(store.selectedTimeOfDay == time ? Color.white: Color.mmGray3)
                            .cornerRadius(12)
                    }
                }
            }

            Spacer()

            MMRoundedButton(isEnabled: $store.isAllCompleted, title: "완성") {
                store.send(.completeButtonTapped)
            }
            .frame(height: 60)
            .padding(.bottom, 36)
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .padding(.horizontal, 24)
        .fullScreenCover(
            item: $store.scope(state: \.missionCreationCompleted, action: \.missionCreationCompleted)
        ) { store in
            MissionCreationCompletedView(store: store)
        }
    }

    var guidanceHeaderView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                Text("해당 시간에만 인증 가능")
                    .foregroundStyle(Color.mmOrange)
                Text("해요!")
            }
            Text("신중히 선택해주세요.")
        }
        .font(.pretendard(kind: .title_xl, type: .light))

    }
}
