//
//  LogoutConfirmView.swift
//  FeatureSettingInterface
//
//  Created by 김용재 on 8/15/24.
//
import SwiftUI

import SharedDesignSystem
import DomainAuth
import DomainAuthInterface
import DataRemote
import DataRemoteInterface

import ComposableArchitecture

public struct LogoutConfirmView: View {
        
    @Bindable public var store: StoreOf<LogoutConfirmFeature>
    @State private var scale = 0.5

    public init(store: StoreOf<LogoutConfirmFeature>) {
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
                    title: "로그아웃\n하시겠습니까?",
                    content: {
                        EmptyView()
                    },
                    primaryButtonTitle: "로그아웃",
                    primaryButtonAction: {
                        store.send(.logoutButtonTapped)
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
