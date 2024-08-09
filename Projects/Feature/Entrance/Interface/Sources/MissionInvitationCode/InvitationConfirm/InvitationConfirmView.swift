//
//  InvitationConfirmView.swift
//  FeatureEntrance
//
//  Created by 김용재 on 8/9/24.
//

import SwiftUI

import SharedDesignSystem

public struct InvitationConfirmView: View {
    
    public init() {} 
    
    public var body: some View {
        ZStack {
            Color.mmBlack
                .opacity(0.7)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                MMPopUpView(
                    title: "초대받은 경쟁이 맞나요?",
                    subtitle: "*기간 대비 인증 요일을 계산해\n 인증횟수(보드판 수)는 총 12개가\n 생성되었습니다.",
                    highlightedSubtitle: "인증횟수(보드판 수)는 총 12개",
                    content: {
                        VStack(alignment: .leading, spacing: 8) {
                            InfoRow(title: "미션", content: "메일 유신소 1시간")
                            Divider()
                            InfoRow(title: "미션 기간", content: "2024.07.24~2024.08.14")
                            Divider()
                            InfoRow(title: "인증 요일", content: "월/수/목")
                            Divider()
                            InfoRow(title: "인증 시간", content: "오전 00~12시")
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
