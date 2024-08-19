//
//  PieceCreationCompletedView.swift
//  FeatureEntranceInterface
//
//  Created by 김용재 on 8/20/24.
//

import SwiftUI

import SharedDesignSystem
import DomainUserInterface

import ComposableArchitecture

public struct PieceCreationCompletedView: View {
    
    @Bindable public var store: StoreOf<PieceCreationCompletedFeature>
    @State private var scale = 0.5
    
    public init(store: StoreOf<PieceCreationCompletedFeature>) {
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
                    title: "\(store.nickName)님, 프로필 완성!",
                    subtitle: "캐릭터와 닉네임은 프로필 수정에서\n언제든지 바꿀 수 있어요!",
                    content: {
                        Image(uiImage: store.character.roundBorderImage.image)
                            .resizable()
                            .frame(width: 180, height: 180)
                            .padding(.top, 32)
                    },
                    primaryButtonTitle: "확인")
                {
                    store.send(.confirmButtonTapped)
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
