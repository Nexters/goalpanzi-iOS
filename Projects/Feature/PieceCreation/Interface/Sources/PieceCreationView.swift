//
//  PieceCreationView.swift
//  FeaturePieceCreationInterface
//
//  Created by 김용재 on 7/30/24.
//

import SwiftUI

import ComposableArchitecture
import SharedDesignSystem

public struct PieceCreationView: View {
    @Bindable public var store: StoreOf<PieceCreationFeature>

    public init(store: StoreOf<PieceCreationFeature>) {
        self.store = store
        SharedDesignSystemFontFamily.registerAllCustomFonts()
    }

    public var body: some View {
        VStack {
            Text("프로필 만들기")
                .font(.pretendard(kind: .heading_sm, type: .bold))
                .foregroundColor(MissionMateColor.gray1)

            Spacer().frame(height: 48)

            Image(uiImage: store.selectedPiece.roundImage)
                .resizable()
                .scaledToFit()
                .frame(width: 220, height: 220)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    Spacer().frame(width: 16)
                    ForEach(Piece.allCases, id: \.self) { piece in
                        VStack {
                            Image(uiImage: piece.basicImage)
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
                                .foregroundColor(MissionMateColor.gray2)
                                .background(MissionMateColor.gray5)
                                .opacity(piece == store.selectedPiece ? 1.0 : 0.3)
                                .cornerRadius(20)
                        }
                    }
                }
            }

            Spacer().frame(height: 18)

            MissionMateTextField(
                text: $store.nickName,
                isValidInputText: $store.isValidNickName,
                placeholder: "닉네임 입력",
                noticeMessage: "1~6자, 한글, 영문 또는 숫자를 입력하세요."
            )
            .padding(.horizontal, 24)

            Spacer().frame(height: 70)

            MissionMateRoundedButton(isDisabled: $store.isAllCompleted, title: "저장하기") {
                print("Button Tapped")
            }
            .frame(maxWidth: .infinity) // Ensure button stretches horizontally
            .frame(height: 60)
            .padding(.horizontal, 24)
            .padding(.bottom, 36)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
