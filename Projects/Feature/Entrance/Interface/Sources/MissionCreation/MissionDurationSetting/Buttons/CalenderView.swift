//
//  CalenderView.swift
//  FeatureEntrance
//
//  Created by Miro on 10/31/24.
//


import SwiftUI

import SharedDesignSystem
import SharedUtil

import HorizonCalendar

struct CalenderView: View {

    @Binding var selectedDate: Date?
    let startDate: Date
    let endDate: Date

    var body: some View {
        calendar()
    }

    init(isStart: Bool, selectedDate: Binding<Date?>, startDate: Date) {
        self._selectedDate = selectedDate
        self.startDate = startDate

        if isStart {
            self.endDate = Calendar.current.date(byAdding: .year, value: 1, to: startDate) ?? Date()
        } else {
            self.endDate = Calendar.current.date(byAdding: .day, value: 30, to: startDate) ?? Date()
        }
    }

    func calendar() -> some View {
        let calendar = Calendar.current

        return CalendarViewRepresentable(
            calendar: calendar,
            visibleDateRange: startDate...endDate,
            monthsLayout: .horizontal(options: .init()),
            dataDependency: selectedDate
        )
        .monthHeaders { month in
            let year = String(month.components.year ?? 0)
            let month = String(month.components.month ?? 0)
            return Text("\(year)년 \(month)월")
                .font(.title2)
                .padding()
        }
        .onDaySelection { [startDate, endDate] day in
            if let date = calendar.date(from: day.components) {
                if date >= startDate && date <= endDate {
                    selectedDate = date
                }
            }
        }
        .days { [startDate, endDate, selectedDate] day in
            let date = calendar.date(from: day.components) ?? Date()
            let backgroundColor: Color
            var isOutOfRange = false

            if date < startDate || date > endDate {
                backgroundColor = Color.mmDisabled
                isOutOfRange = true
            } else {
                backgroundColor = date == selectedDate ? Color.mmOrange : .clear
            }

            return Text("\(day.day)")
                .font(.system(size: 18))
                .foregroundColor(Color(UIColor.label))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    if isOutOfRange {
                        Rectangle()
                            .fill(backgroundColor)
                    } else {
                        Circle()
                            .fill(backgroundColor)
                    }
                }
        }
    }
}
