//
//  MMCapsuleTagView.swift
//  SharedDesignSystem
//
//  Created by Miro on 8/6/24.
//

import SwiftUI

public struct MMCapsuleTagView: View {
    private let text: String
    private let horizontalPadding: CGFloat
    private let verticalPadding: CGFloat
    private let font: Font

    public init(text: String, font: Font, horizontalPadding: CGFloat, verticalPadding: CGFloat) {
        self.text = text
        self.font = font
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
    }
    public var body: some View {
        Text(text)
            .font(font)
            .foregroundColor(Color.mmOrange)
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .background(
                Capsule()
                    .fill(.clear)
            )
            .overlay(
                Capsule()
                    .stroke(Color.mmOrange, lineWidth: 1)
            )
    }
}
