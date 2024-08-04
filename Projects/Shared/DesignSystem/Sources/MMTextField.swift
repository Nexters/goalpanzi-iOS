//
//  MissionMateTextField.swift
//  SharedDesignSystemInterface
//
//  Created by Miro on 8/3/24.
//

import SwiftUI

public struct MMTextField: View {
    @Binding public var text: String
    @Binding public var isValidInputText: Bool
    @Binding public var noticeMessage: String?

    public let placeholder: String

    public init(text: Binding<String>, isValidInputText: Binding<Bool>, noticeMessage: Binding<String?>, placeholder: String) {
        self._text = text
        self._isValidInputText = isValidInputText
        self._noticeMessage = noticeMessage
        self.placeholder = placeholder
    }

    public var body: some View {
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
