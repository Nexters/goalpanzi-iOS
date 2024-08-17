//
//  InvitationConfirmView.swift
//  FeatureEntrance
//
//  Created by 김용재 on 8/9/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct InvitationConfirmView: View {
    
    @Bindable public var store: StoreOf<InvitationConfirmFeature>
    @State private var scale = 0.5

    public init(store: StoreOf<InvitationConfirmFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack {
            Color.mmBlack
                .opacity(0.7)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                MMPopUpView(
                    title: "초대받은 경쟁이 맞나요?",
                    subtitle: "*기간 대비 인증 요일을 계산해\n 인증횟수(보드판 수)는 총 \(store.authenticationDays)개가\n 생성되었습니다.",
                    highlightedSubtitle: "인증횟수(보드판 수)는 총 \(store.authenticationDays)개",
                    content: {
                        VStack(alignment: .leading, spacing: 8) {
                            InfoRow(title: "미션", content: store.missionTitle)
                            Divider()
                            InfoRow(title: "미션 기간", content: store.missionDuration)
                            Divider()
                            InfoRow(title: "인증 요일", content: store.missionWeekDay)
                            Divider()
                            InfoRow(title: "인증 시간", content: store.missionTimeOfDay)
                        }
                        .padding(.top, 29)
                    }, primaryButtonTitle: "맞아요", primaryButtonAction: {
                        store.send(.confirmButtonTapped)
                    }, secondaryButtonTitle: "아니에요") {
                        store.send(.denyButtonTapped)
                    }
                    .padding(.horizontal, 24)
                Spacer()
            }
            .scaleEffect(scale)
            .animate(using: .spring(response: 0.3, dampingFraction: 0.8, blendDuration: 0)) {
                scale = 1.0
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct InfoRow: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.pretendard(kind: .body_md, type: .light))
                .foregroundColor(Color.mmGray3)
            Text(content)
                .font(.pretendard(kind: .body_lg, type: .bold))
                .foregroundColor(Color.mmGray1)
        }
        .frame(height: 52)
    }
}
