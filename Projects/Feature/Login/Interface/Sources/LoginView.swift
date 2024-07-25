//
//  LoginView.swift
//  FeatureLoginInterface
//
//  Created by Miro on 7/25/24.
//

import SwiftUI

import ComposableArchitecture
import Shared
import SharedDesignSystem

public struct LoginView: View {
    public let store: StoreOf<LoginFeature>

    public init(store: StoreOf<LoginFeature>) {
        self.store = store
    }

    public var body: some View {
        VStack(spacing: 0) {
            Spacer()

            Rectangle()
                .fill(Color.blue)
                .frame(width: 342, height: 342)

            Spacer()

            VStack(spacing: 8) {
                SocialLoginButton() {
                    store.send(.appleLoginButtonTapped)
                }
                Text("소셜 계정으로 간편 기입하기")
                    .font(.system(size: 12, weight: .regular)) // DesignSystem 결정되면 바꿀 예정
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 203)
        }
        .background(Color.green)
    }
}

struct SocialLoginButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(uiImage: SharedDesignSystemAsset.appleIcon.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 26, height: 26)
                    .padding(.leading, 27)

                Spacer()

                Text("Apple로 로그인")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(.black)

                Spacer()
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity, maxHeight: 60)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 30))
        }
    }
}

