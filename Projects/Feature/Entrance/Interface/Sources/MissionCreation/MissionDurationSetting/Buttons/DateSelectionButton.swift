//
//  DateSelectionButton.swift
//  FeatureEntranceInterface
//
//  Created by Miro on 8/7/24.
//

import SwiftUI

import SharedDesignSystem

struct DaySelectionButton: View {
    let day: Weekday
    let isSelected: Bool
    let isAnySelected: Bool
    let action: () -> Void

    private var backgroundColor: Color {
        if isSelected {
            return .mmGray1
        } else if !isAnySelected {
            return .mmGray5.opacity(0.3) // 더 짙은 회색
        } else {
            return .mmGray5  // 기존의 밝은 회색
        }
    }

    private var foregroundColor: Color {
        if isSelected {
            return .mmWhite
        } else if !isAnySelected {
            return .mmGray1.opacity(0.3) // 더 짙은 회색
        } else {
            return .mmGray1  // 기존의 밝은 회색
        }
    }

    var body: some View {
        Button(action: action) {
            Text(day.koreanName)
                .frame(width: 40, height: 40)
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .cornerRadius(20)
        }
    }
}
