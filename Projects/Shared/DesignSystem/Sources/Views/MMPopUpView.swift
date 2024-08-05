//
//  MMPopUpView.swift
//  SharedDesignSystem
//
//  Created by Miro on 8/6/24.
//

import SwiftUI

public struct MMPopUpView<Content: View>: View {

    private let title: String
    private let highlightedTitle: String?
    private let subtitle: String
    private let highlightedSubtitle: String?
    private let content: Content
    private let primaryButtonTitle: String
    private let primaryButtonAction: () -> Void
    private let secondaryButtonTitle: String?
    private let secondaryButtonAction: (() -> Void)?

    init(
        title: String,
        highlightedTitle: String? = nil,
        subtitle: String,
        highlightedSubtitle: String? = nil,
        @ViewBuilder content: () -> Content,
        primaryButtonTitle: String,
        primaryButtonAction: @escaping () -> Void,
        secondaryButtonTitle: String? = nil,
        secondaryButtonAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.highlightedTitle = highlightedTitle
        self.subtitle = subtitle
        self.highlightedSubtitle = highlightedSubtitle
        self.content = content()
        self.primaryButtonTitle = primaryButtonTitle
        self.primaryButtonAction = primaryButtonAction
        self.secondaryButtonTitle = secondaryButtonTitle
        self.secondaryButtonAction = secondaryButtonAction
    }

    public  var body: some View {
        VStack(spacing: 12) {
            Spacer().frame(height: 40)

            if let highlighted = highlightedTitle {
                highlightedTextView(
                    text: title,
                    highlighted: highlighted,
                    font: .pretendard(kind: .title_xl, type: .bold)
                )
            } else {
                Text(title)
                    .font( .pretendard(kind: .title_xl, type: .bold))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity)
            }

            if let highlighted = highlightedSubtitle {
                highlightedTextView(
                    text: subtitle,
                    highlighted: highlighted,
                    font: .pretendard(kind: .body_xl, type: .light)
                )
            } else {
                Text(subtitle)
                    .font(.pretendard(kind: .body_xl, type: .light))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity)
            }

            Group {
                if !(content is EmptyView) {
                    Spacer().frame(height: 32)
                    content
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer().frame(height: 32)
                }
            }

            Button(action: primaryButtonAction) {
                Text(primaryButtonTitle)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.mmOrange)
                    .foregroundColor(.white)
                    .cornerRadius(30)
            }

            if let secondaryTitle = secondaryButtonTitle,
               let secondaryAction = secondaryButtonAction {
                Button(action: secondaryAction) {
                    Text(secondaryTitle)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.gray)
                }
            }

            Spacer().frame(height: 34)
        }
        .padding(.horizontal, 24)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 12)
    }

    private func highlightedTextView(text: String, highlighted: String, font: Font) -> some View {
        let lines = text.components(separatedBy: "\n")

        return VStack(alignment: .center, spacing: 4) {
            ForEach(lines.indices, id: \.self) { lineIndex in
                let line = lines[lineIndex]
                let parts = line.components(separatedBy: highlighted)

                HStack(spacing: 0) {
                    ForEach(parts.indices, id: \.self) { partIndex in
                        if partIndex > 0 {
                            Text(highlighted)
                                .foregroundColor(.orange)
                        }
                        Text(parts[partIndex])
                    }
                }
            }
        }
        .font(font)
        .multilineTextAlignment(.center)
        .fixedSize(horizontal: false, vertical: true)
    }
}
