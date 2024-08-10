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
                        .padding(.vertical, 29)
                    }, primaryButtonTitle: "맞아요", primaryButtonAction: {
                        print("")
                    }, secondaryButtonTitle: "아니에요") {
                        print("")
                    }
                    .padding(.horizontal, 24)
                Spacer()
            }
        }
        .background(Color.clear)
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
