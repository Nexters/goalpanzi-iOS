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
                .padding(.leading, 10) // Padding on the left side for spacing
                .frame(height: 60)
                .foregroundColor(
                    text.isEmpty ? SharedDesignSystemAsset.Colors.gray3.swiftUIColor : SharedDesignSystemAsset.Colors.gray2.swiftUIColor
                )
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(text.isEmpty ? SharedDesignSystemAsset.Colors.gray4.swiftUIColor : SharedDesignSystemAsset.Colors.white.swiftUIColor)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            // completed가 아니면 red, empty이면 clear, empty x면 gray 4
                            !isValidInputText ? Color.red : (text.isEmpty ? Color.clear : SharedDesignSystemAsset.Colors.gray4.swiftUIColor),
                            lineWidth: 1
                        )
                )

            if let noticeMessage {
                Text(noticeMessage)
                    .foregroundColor(
                        isValidInputText ? SharedDesignSystemAsset.Colors.gray3.swiftUIColor : SharedDesignSystemAsset.Colors.red.swiftUIColor
                    )
                    .padding(.top, 8)
            }
        }
    }
}
