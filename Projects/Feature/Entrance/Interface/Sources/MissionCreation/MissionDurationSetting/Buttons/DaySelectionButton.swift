//
//  DaySelectionButton.swift
//  FeatureEntranceInterface
//
//  Created by Miro on 8/7/24.
//

import SwiftUI

import SharedDesignSystem

struct DateSelectionButton: View {
    let isStartDateSelection: Bool
    let calendar = Calendar.current
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
            .font(.pretendard(size: 16, type: .medium))
            .foregroundStyle(textColor)
            .background(backgroundColor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 1)
                    .overlay {
                        DatePicker(
                            selection: Binding(
                                get: {
                                    self.date ?? minimumDate
                                },
                                set: {
                                    self.date = calendar.startOfDay(for: $0)
                                }),
                            in: dateRange,
                            displayedComponents: .date
                        ) {}
                            .labelsHidden()
                            .colorMultiply(.clear)
                    }
            )
            .disabled(!isEnabled)
    }
    
    private var dateRange: ClosedRange<Date> {
        return isStartDateSelection ? minimumDate-1...Date.distantFuture : minimumDate...(calendar.date(byAdding: .month, value: 1, to: minimumDate) ?? Date())
    }
}
