//
//  EntranceView.swift
//  FeatureEntranceInterface
//
//  Created by Miro on 8/5/24.
//

import SwiftUI

import DomainUserInterface
import SharedDesignSystem

import ComposableArchitecture

public struct EntranceView: View {

    public var store: StoreOf<EntranceFeature>

    public init(store: StoreOf<EntranceFeature>) {
        self.store = store
    }

    public var body: some View {
        VStack(spacing: 0) {
            Spacer()

            Text("미션 완수를 위해\n경쟁할 준비가 되었나요?")
                .font(.pretendard(kind: .heading_sm, type: .bold))
                .multilineTextAlignment(.center)

            Spacer(minLength: 52)

            MMCapsuleTagView(text: "LV1. 제주도")

            Spacer()

            ZStack {
                Image(uiImage: SharedDesignSystemAsset.Images.jejuIslandBackground.image)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350, height: 228)
                // TODO: 추후에 Input으로 받을 예정
                Image(uiImage: Character.rabbit.basicImage.image)
                    .resizable()
                    .frame(width: 212, height: 212)
            }

            Spacer()

            HStack(spacing: 23) {
                entranceSelectionButton(
                    title: "미션보드\n생성하기",
                    description: "내 목표는 내가~",
                    iconImage: SharedDesignSystemAsset.Images.coloredPencil.image
                ) {
                    store.send(.createMissionButtonTapped)
                }

                entranceSelectionButton(
                    title: "초대코드\n입력하기",
                    description: "초대받고 왔지~",
                    iconImage: SharedDesignSystemAsset.Images.coloredAddPerson.image
                ) {
                    store.send(.enterInvitationCodeButtonTapped)
                }
            }

            Spacer()
        }
    }

    private func entranceSelectionButton(
        title: String,
        description: String,
        iconImage: UIImage,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.mmBlack.opacity(0.2), lineWidth: 1)
                .frame(width: 162, height: 188)
                .overlay(
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(title)
                                .font(.pretendard(kind: .title_xl, type: .bold))
                                .foregroundStyle(Color.mmGray1)
                                .multilineTextAlignment(.leading)
                            Text(description)
                                .font(.pretendard(kind: .body_lg, type: .medium))
                                .foregroundStyle(Color.mmGray3)
                        }
                        Spacer()
                        HStack {
                            Spacer()
                            Image(uiImage: iconImage)
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                    }.padding(20)
                )
        }
    }
}
