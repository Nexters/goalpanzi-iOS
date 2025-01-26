//
//  UnsavedChangesAlertView.swift
//  FeatureSetting
//
//  Created by Miro on 10/30/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct UnsavedChangesAlertView: View {

    @Bindable public var store: StoreOf<UnsavedChangesAlertFeature>
    @State private var scale = 0.5

    public init(store: StoreOf<UnsavedChangesAlertFeature>) {
        self.store = store
    }

    public var body: some View {
        ZStack {
            Color.mmBlack
                .opacity(0.7)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                MMPopUpView(
                    title: "아직 수정중이에요\n이대로 나가시나요?",
                    subtitle: "나가면 캐릭터 수정이 반영되지 않아요",
                    content: {
                        EmptyView()
                    },
                    primaryButtonTitle: "나가기",
                    primaryButtonAction: {
                        store.send(.exitButtonTapped)
                    },
                    secondaryButtonTitle: "계속 작성하기") {
                        store.send(.cancelButtonTapped)
                    }
                    .padding(.horizontal, 24)
                Spacer()
            }
            .scaleEffect(scale)
            .animate(using: .spring(response: 0.3, dampingFraction: 0.8, blendDuration: 0)) {
                scale = 1.0
            }
        }
        .ignoresSafeArea(.all)
    }
}
