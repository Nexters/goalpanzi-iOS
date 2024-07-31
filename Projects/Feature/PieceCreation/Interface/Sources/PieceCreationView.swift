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
                                .frame(height: 24)
                                .padding(.horizontal, 25)
                                .foregroundColor(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
                                .background(SharedDesignSystemAsset.Colors.gray5.swiftUIColor)
                                .opacity(piece == store.selectedPiece ? 1.0 : 0.3)
                                .cornerRadius(20)
                        }
                    }
                }
            }
            MissionMateTextField(
                text: $store.nickName,
                isValidInputText: $store.isValidNickName,
                placeholder: "닉네임 입력",
                noticeMessage: "1~6자, 한글, 영문 또는 숫자를 입력하세요."
            )
            .padding(.horizontal, 24)
        }
        .frame(maxHeight: .infinity)
    }
}
