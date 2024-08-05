//
//  MMCapsuleTagView.swift
//  SharedDesignSystem
//
//  Created by Miro on 8/6/24.
//

import SwiftUI

public struct MMCapsuleTagView: View {
    public let text: String

    public init(text: String) {
        self.text = text
    }

    public var body: some View {
        Text(text)
            .font(.pretendard(kind: .title_lg, type: .medium))
            .foregroundColor(Color.mmOrange)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(.clear)
            )
            .overlay(
                Capsule()
                    .stroke(.orange, lineWidth: 1)
            )
    }
}
