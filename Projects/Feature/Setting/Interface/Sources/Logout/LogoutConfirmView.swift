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
        }
    }
}
