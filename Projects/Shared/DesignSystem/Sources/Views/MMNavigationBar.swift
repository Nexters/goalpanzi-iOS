//
//  MMNavigationBar.swift
//  SharedDesignSystem
//
//  Created by Miro on 8/6/24.
//

import SwiftUI

public struct MMNavigationBar: View {
    public var title: String?
    public var navigationAccessoryItem: AnyView?
    public var backButtonAction: () -> Void

    public init(
        title: String? = nil,
        navigationAccessoryItem: AnyView? = nil,
        backButtonAction: @escaping () -> Void
    ) {
        self.title = title
        self.navigationAccessoryItem = navigationAccessoryItem
        self.backButtonAction = backButtonAction
    }

    public var body: some View {
        VStack(alignment: .leading) {
            Button {
                backButtonAction()
            } label: {
                Image(uiImage: SharedDesignSystemAsset.Images.backButton.image)
                    .resizable()
                    .frame(width: 12, height: 20)
            }

            HStack {
                if let title {
                    VStack {
                        Spacer()
                            .frame(height: 15)
                        Text(title)
                            .foregroundStyle(Color.mmGray1)
                            .font(.pretendard(kind: .heading_sm, type: .bold))
                    }

                }

                Spacer()

                if let accessoryItem = navigationAccessoryItem {
                    VStack {
                        Spacer()
                            .frame(height: 15)
                        accessoryItem
                    }
                }
            }
        }
        .background(Color.mmWhite)
        .frame(maxWidth: .infinity)
    }
}
