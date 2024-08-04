//
//  MissionMateRoundedButton.swift
//  SharedDesignSystemInterface
//
//  Created by Miro on 8/3/24.
//

import SwiftUI

public struct MMRoundedButton: View {
    @Binding var isEnabled: Bool
    public let title: String
    public let action: () -> Void

    public init(isEnabled: Binding<Bool>, title: String, action: @escaping () -> Void) {
        self._isEnabled = isEnabled
        self.title = title
        self.action = action
    }

    public var body: some View {
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
