//
//  MissionMateTextField.swift
//  FeaturePieceCreationInterface
//
//  Created by Miro on 7/31/24.
//

import SwiftUI

import SharedDesignSystem

struct MissionMateTextField: View {
    @Binding var text: String
    @Binding var isValidInputText: Bool

    let placeholder: String
    var noticeMessage: String? = nil

    var body: some View {
        VStack(alignment: .leading) {
            TextField(placeholder, text: $text)
                .font(.pretendard(kind: .body_lg, type: .medium))
                .padding(.leading, 10)
                .frame(height: 60)
                .foregroundColor(text.isEmpty ? MissionMateColor.gray3 : MissionMateColor.gray1)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(text.isEmpty ? MissionMateColor.gray5 : MissionMateColor.white)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            !isValidInputText ? MissionMateColor.red : (text.isEmpty ? Color.clear : MissionMateColor.gray4),
                            lineWidth: !isValidInputText ? 2 : 1
                        )
                )

            if let noticeMessage {
                Text(noticeMessage)
                    .font(.pretendard(size: 14, type: .medium))
                    .foregroundColor(
                        isValidInputText ? MissionMateColor.gray3 : MissionMateColor.red
                    )
                    .padding(.top, 8)
            }
        }
    }
}
