//
//  MyHistoryView+FailureView.swift
//  MissionMate
//
//  Created by Haeseok Lee on 6/1/25.
//

import SwiftUI
import SharedDesignSystem

extension MyHistoryView {
    
    struct FailureView: View {
        
        @ViewBuilder
        var body: some View {
            VStack {
                Text("알 수 없는 오류가 발생했습니다.")
                    .foregroundStyle(Color.mmGray1)
                    .font(.pretendard(kind: .body_md, type: .regular))
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
