//
//  MissionDurationSettingView.swift
//  FeatureEntrance
//
//  Created by 김용재 on 8/7/24.
//

import SwiftUI

import SharedDesignSystem
import SharedUtil

import ComposableArchitecture

public struct MissionDurationSettingView: View {
    
    @State private var startDate: Date?
    @State private var endDate: Date?
    @State private var startMinimumDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    @State private var endMinimumDate = Date()
    @State private var isStartDateSelected = false
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 0) {
            MMNavigationBar(
                title: "기간 및 요일 설정",
                navigationAccessoryItem: AnyView(MMCapsuleTagView(
                    text: "2/3",
                    font: .pretendard(kind: .body_xl, type: .medium),
                    horizontalPadding: 14,
                    verticalPadding: 1
                ))
            ) {
                print("backButtonTapped")
            }
            .padding(.horizontal, 24)
            
            HStack {
                DateSelectionButton(
                    date: $startDate,
                    minimumDate: .constant(startMinimumDate),
                    isEnabled: .constant(true),
                    placeHolder: "시작일"
                )
                .onChange(of: startDate, { oldValue, newValue in
                    isStartDateSelected = true
                    guard let startDate else { return }
                    endMinimumDate = Calendar.current.date(byAdding: .day, value: 2, to: startDate) ?? Date()
                })
                Text("~")
                DateSelectionButton(
                    date: $endDate,
                    minimumDate: $endMinimumDate,
                    isEnabled: $isStartDateSelected,
                    placeHolder: "마감일"
                )
            }
            .frame(maxWidth: .infinity)
        }
    }
}

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
            .font(.pretendard(kind: .body_sm, type: .medium)) // TODO: 폰트 수정해야됨!~!~!~!
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
