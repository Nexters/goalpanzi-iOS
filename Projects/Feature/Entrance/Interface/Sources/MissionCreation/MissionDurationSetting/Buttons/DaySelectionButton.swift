//
//  DaySelectionButton.swift
//  FeatureEntranceInterface
//
//  Created by Miro on 8/7/24.
//

import SwiftUI

import SharedDesignSystem

struct DateSelectionButton: View {
    @Binding var date: Date?
    @Binding var minimumDate: Date
    @Binding var isEnabled: Bool

    let placeHolder: String

    private var isDateSelected: Bool {
        date != nil
    }

    private var displayText: String {
        date?.formattedString(dateFormat: .yearMonthDate) ?? placeHolder
    }

    private var textColor: Color {
        isDateSelected ? .black : .mmGray3
    }

    private var backgroundColor: Color {
        isDateSelected ? .white : .mmGray5
    }

    private var borderColor: Color {
        isDateSelected ? .mmGray4 : .clear
    }

    var body: some View {
        Text(displayText)
            .padding()
            .frame(width: 159, height: 60, alignment: .leading)
            .font(.pretendard(size: 16, type: .medium)) // TODO: 폰트 수정해야됨!~!~!~!
            .foregroundStyle(textColor)
            .background(backgroundColor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 1)
                    .overlay {
                        DatePicker(
                            selection: Binding(
                                get: { self.date ?? Date() },
                                set: { self.date = $0 }),
                            in: minimumDate...,
                            displayedComponents: .date) {}
                            .labelsHidden()
                            .colorMultiply(.clear)
                    }
            )
            .disabled(!isEnabled)
    }
}
