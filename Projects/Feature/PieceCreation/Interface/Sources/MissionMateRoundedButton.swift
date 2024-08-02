//
//  MissionMateRoundedButton.swift
//  FeaturePieceCreationInterface
//
//  Created by Miro on 8/1/24.
//

import SwiftUI

import SharedDesignSystem

struct MissionMateRoundedButton: View {
    @Binding var isEnabled: Bool
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            Text(title)
                .font(.pretendard(kind: .body_lg, type: .bold))
                .foregroundColor(.mmWhite)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(isEnabled ? Color.mmOrange : Color.mmDisabled)
        )
        .disabled(!isEnabled)
    }
}
