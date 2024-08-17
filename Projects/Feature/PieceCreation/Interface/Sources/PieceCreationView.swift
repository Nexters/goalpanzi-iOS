//
//  PieceCreationView.swift
//  FeaturePieceCreationInterface
//
//  Created by 김용재 on 7/30/24.
//

import SwiftUI

import SharedDesignSystem
import SharedDesignSystemInterface
import DomainUserInterface

import ComposableArchitecture

public struct PieceCreationView: View {
    @Bindable public var store: StoreOf<PieceCreationFeature>

    @FocusState private var isTextFieldFocused: Bool
    @ObservedObject private var keyboardResponder = KeyboardResponder()

    public init(store: StoreOf<PieceCreationFeature>) {
        self.store = store
    }

    public var body: some View {
        VStack {
            Text("프로필 만들기")
                .font(.pretendard(kind: .heading_sm, type: .bold))
                .foregroundColor(.mmGray1)
                .padding(.top, 48)

            Spacer()

            Image(uiImage: store.selectedPiece.roundImage.image)
                .resizable()
                .scaledToFit()
                .frame(width: 220, height: 220)
                .padding(.top, 48)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    Spacer().frame(width: 16)
                    ForEach(Character.allCases, id: \.self) { piece in
                        VStack {
                            Image(uiImage: piece.basicImage.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .opacity(piece == store.selectedPiece ? 1.0 : 0.3)
                                .onTapGesture {
                                    store.send(.pieceImageTapped(piece))
                                }
                            Text(piece.koreanName)
                                .font(.pretendard(kind: .body_md, type:.bold))
                                .frame(height: 24)
                                .padding(.horizontal, 25)
                                .foregroundColor(.mmGray2)
                                .background(Color.mmGray5)
                                .opacity(piece == store.selectedPiece ? 1.0 : 0.3)
                                .cornerRadius(20)
                        }
                    }
                }
            }
            .padding(.top, 16)

            Spacer()

            MMTextField(
                text: $store.nickName,
                isValidInputText: $store.isValidNickName,
                noticeMessage: $store.noticeMessage,
                placeholder: "닉네임 입력"
            )
            .focused($isTextFieldFocused)
            .padding(.horizontal, 24)

            Spacer()

            MMRoundedButton(isEnabled: $store.isAllCompleted, title: "저장하기") {
                store.send(.saveButtonTapped)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .padding(.horizontal, 24)
            .padding(.bottom, 36)
        }
        .padding(.bottom, keyboardResponder.currentHeight)
        .animation(.easeOut(duration: 0.3), value: keyboardResponder.currentHeight)
        .onTapGesture {
            isTextFieldFocused = false
        }
    }
}
