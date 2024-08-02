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
                .foregroundColor(text.isEmpty ? .mmGray3 : .mmGray1)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(text.isEmpty ? Color.mmGray5 : Color.mmWhite)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            !isValidInputText ? .mmRed : (text.isEmpty ? Color.clear : .mmGray4),
                            lineWidth: !isValidInputText ? 2 : 1
                        )
                )

            if let noticeMessage {
                Text(noticeMessage)
                    .font(.pretendard(size: 14, type: .medium))
                    .foregroundColor(
                        isValidInputText ? .mmGray3 : .mmRed
                    )
                    .padding(.top, 8)
            }
        }
    }
}
