//
//  ProfileDeletionView.swift
//  FeatureSettingInterface
//
//  Created by 김용재 on 8/15/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct ProfileDeletionView: View {
        
    @Bindable public var store: StoreOf<ProfileDeletionFeature>
    @State private var scale = 0.5

    public init(store: StoreOf<ProfileDeletionFeature>) {
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
                    title: "계정탈퇴\n하시겠습니까?",
                    subtitle: "탈퇴하면 저장된 데이터가\n모두 초기화돼요.",
                    content: {
                        EmptyView()
                    },
                    primaryButtonTitle: "탈퇴하기",
                    primaryButtonAction: {
                        store.send(.deleteProfileButtonTapped)
                    },
                    secondaryButtonTitle: "취소") {
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
