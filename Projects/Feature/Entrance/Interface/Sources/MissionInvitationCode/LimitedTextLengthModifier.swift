//
//  LimitedTextLengthModifier.swift
//  FeatureEntranceInterface
//
//  Created by Miro on 8/8/24.
//

import SwiftUI

import Combine

import SharedDesignSystem

struct LimitedTextLengthModifier: ViewModifier {
    @Binding var inputText: String
    @Binding var isAllInvalid: Bool
    @Binding var isAllEmpty: Bool

    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .onReceive(Just(inputText)) { _ in limitText() }
            .font(.pretendard(kind: .heading_md, type: .bold))
            .foregroundStyle(foregroundColor)
            .frame(width: 72, height: 72)
            .background(backgroundColor)
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderLineColor, lineWidth: 2)
            )
    }

    private var foregroundColor: Color {
        if isAllEmpty {
            return Color.mmDisabled
        } else {
            return Color.mmGray1
        }
    }

    private var backgroundColor: Color {
        if isAllEmpty {
            return Color.mmGray5
        } else {
            return Color.mmWhite
        }
    }

    private var borderLineColor: Color {
        if isAllInvalid {
            return Color.mmRed
        } else if isAllEmpty {
            return Color.mmWhite
        } else {
            return Color.mmGray4
        }
    }

    private func limitText() {
        inputText = String(inputText.prefix(1))
    }
}
