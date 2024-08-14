//
//  AccountDeletionView.swift
//  FeatureSettingInterface
//
//  Created by 김용재 on 8/15/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct AccountDeletionView: View {
        
    @Bindable public var store: StoreOf<AccountDeletionFeature>

    public init(store: StoreOf<AccountDeletionFeature>) {
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
//                        store.send(.confirmButtonTapped)
                    },
                    secondaryButtonTitle: "취소") {
//                        store.send(.denyButtonTapped)
                    }
                    .padding(.horizontal, 24)
                Spacer()
            }
        }
    }
}
