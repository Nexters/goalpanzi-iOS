//
//  CalendarPopupView.swift
//  FeatureEntrance
//
//  Created by Miro on 11/1/24.
//

import SwiftUI

struct CalendarPopupView: View {

    let isStart: Bool
    @Binding var isShowing: Bool
    @Binding var selectedDate: Date?
    let startDate: Date

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button(action: {
                    isShowing = false
                }) {
                    Text("선택완료")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 15)
            .padding(.bottom, 45)

            CalenderView(
                isStart: isStart,
                selectedDate: $selectedDate,
                startDate: startDate
            )
            .frame(maxWidth: .infinity, maxHeight: 300)
            .padding(.horizontal, 24)
        }
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 10)
    }
}
