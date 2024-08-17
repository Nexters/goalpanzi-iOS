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
        GeometryReader { geometry in
            
            VStack(spacing: 0) {
                Spacer()
                
                Image(uiImage:SharedDesignSystemAsset.Images.missionmateLogo.image)
                    .resizable()
                    .frame(width: 48, height: 48)
                
                Spacer()
                    .frame(maxHeight: 48)
                
                Image(uiImage:SharedDesignSystemAsset.Images.loginMissionmateTitle.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: geometry.size.height * 0.13)
                
                Spacer()
                    .frame(maxHeight: 30)
                
                VStack(spacing: 0) {
                    
                    Image(uiImage:SharedDesignSystemAsset.Images.basicRabbitWithoutShadow.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: geometry.size.height * 0.26)
                    
                    SocialLoginButton() {
                        store.send(.appleLoginButtonTapped)
                    }
                    .padding(.top, -45)
                    .padding(.bottom, 16)
                    
                    Text("소셜 계정으로 간편 기입하기")
                        .font(.pretendard(size: 14, type: .light))
                        .foregroundStyle(Color.mmWhite)
                }
                .padding(.horizontal, 24)
                
                Image(uiImage:SharedDesignSystemAsset.Images.loginBackground.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: .infinity)
                    .layoutPriority(1)
            }
        }
        .background(SharedDesignSystemAsset.Colors.orange.swiftUIColor)
        .frame(width: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
}

struct SocialLoginButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                HStack {
                    Image(uiImage: SharedDesignSystemAsset.Images.appleIcon.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 26, height: 26)
                        .padding(.leading, 27)
                    
                    Spacer()
                }
                
                Text("Apple로 로그인")
                    .font(.pretendard(size: 16, type: .bold))
                    .foregroundStyle(Color.mmBlack)
            }
        }
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}
