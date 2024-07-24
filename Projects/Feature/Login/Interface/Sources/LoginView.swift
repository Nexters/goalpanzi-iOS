//
//  LoginView.swift
//  FeatureLoginInterface
//
//  Created by Miro on 7/25/24.
//

import SwiftUI

import ComposableArchitecture

public struct LoginView: View {
    public let store: StoreOf<LoginFeature>

    public init(store: StoreOf<LoginFeature>) {
        self.store = store
    }

    public var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 8) {
                SocialLoginButton() {
                    store.send(.appleLoginButtonTapped)
                }
                Text(
                    store.state.appleLoginInformation?.identityToken ?? ""
                )
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 120)
        }
    }
}

struct SocialLoginButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(uiImage: .checkmark)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)

                Text("Apple로 로그인")
                    .font(.title)
                    .foregroundStyle(.red)
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}
